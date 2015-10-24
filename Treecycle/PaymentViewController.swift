//
//  PaymentViewController.swift
//  Treecycle
//
//  Created by Shane Rogers on 10/22/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import UIKit
import AMWaveTransition
import Stripe

class PaymentViewController: AMWaveViewController, UITextFieldDelegate, STPPaymentCardTextFieldDelegate {
    
    // To set this up, see https://github.com/stripe/example-ios-backend
    let backendChargeURLString = ""
    let minPayment = 1000
    
    @IBOutlet weak var payButton: UIButton!
    var paymentTextField: STPPaymentCardTextField!
    @IBOutlet weak var paymentFormView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentTextField = STPPaymentCardTextField(frame: paymentFormView.frame)
        paymentTextField.center = paymentFormView.center
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        
        payButton.enabled = false
        view.addSubview(payButton)
    }
    
    func paymentCardTextFieldDidChange(textField: STPPaymentCardTextField) {
        payButton.enabled = textField.valid
    }
    
    @IBAction func authPayment(sender: AnyObject) {
        let apiClient = STPAPIClient(publishableKey: Stripe.defaultPublishableKey()!)
        let card = paymentTextField.card!
        apiClient.createTokenWithCard(card, completion: { (token, error) -> Void in
            if error == nil {
                if let token = token {
                    self.createBackendChargeWithToken(token, completion: { (result, error) -> Void in
                        if result == STPBackendChargeResult.Success {
                            PKPaymentAuthorizationStatus.Success
                        }
                        else {
                            PKPaymentAuthorizationStatus.Failure
                        }
                    })
                }
            }
            else {
                print("Error\(error)")
//                PKPaymentAuthorizationStatus.Failure
            }
        })
    }
//    STPTokenSubmissionHandler - these are publically available completion handlers which can be used to communicate to checkout the success or failure of a payment
//    convert to use Alamofire
    func createBackendChargeWithToken(token: STPToken, completion: STPTokenSubmissionHandler) {
        if backendChargeURLString != "" {
            if let url = NSURL(string: backendChargeURLString  + "/charge") {
                
                let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
                let request = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                let postBody = "stripeToken=\(token.tokenId)&amount=\(minPayment)"
                let postData = postBody.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                session.uploadTaskWithRequest(request, fromData: postData, completionHandler: { data, response, error in
                    let successfulResponse = (response as? NSHTTPURLResponse)?.statusCode == 200
                    if successfulResponse && error == nil {
                        completion(.Success, nil)
                    } else {
                        if error != nil {
                            completion(.Failure, error)
                        } else {
                            completion(.Failure, NSError(domain: StripeDomain, code: 50, userInfo: [NSLocalizedDescriptionKey: "There was an error communicating with your payment backend."]))
                        }
                        
                    }
                }).resume()
                
                return
            }
        }

//        self.handleError(NSError(domain: StripeDomain, code: 50, userInfo: [NSLocalizedDescriptionKey: "You created a token! Its value is \(token.tokenId). Now configure your backend to accept this token and complete a charge."]))
//        Stripe API error handling
        completion(STPBackendChargeResult.Failure, NSError(domain: StripeDomain, code: 50, userInfo: [NSLocalizedDescriptionKey: "You created a token! Its value is \(token.tokenId). Now configure your backend to accept this token and complete a charge."]))
    }
    
    
//    func createToken() {
//        let card = paymentTextField.card!
//        Stripe.createTokenWithCard(card) { token, error in
//            if let token = token {
//                //send token to backend and create charge
//            }
//        }
//    }

//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as UITableViewCell
//        cell.textLabel!.text = "Section \(indexPath.section), Cell \(indexPath.row)"
//        return cell
//    }
//    
//    let treePrice : UInt = 1000 // this is in cents
//    
//    @IBAction func beginPayment(sender: AnyObject) {
//        if (stripePublishableKey == "") {
//            let alert = UIAlertController(
//                title: "You need to set your Stripe publishable key.",
//                message: "You can find your publishable key at https://dashboard.stripe.com/account/apikeys .",
//                preferredStyle: UIAlertControllerStyle.Alert
//            )
//            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
//            alert.addAction(action)
//            presentViewController(alert, animated: true, completion: nil)
//            return
//        }
//        if (appleMerchantId != "") {
//            if let paymentRequest = Stripe.paymentRequestWithMerchantIdentifier(appleMerchantId) {
//                if Stripe.canSubmitPaymentRequest(paymentRequest) {
//                    paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "Cool shirt", amount: NSDecimalNumber(string: "10.00")), PKPaymentSummaryItem(label: "Stripe shirt shop", amount: NSDecimalNumber(string: "10.00"))]
//                    let paymentAuthVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
//                    paymentAuthVC.delegate = self
//                    presentViewController(paymentAuthVC, animated: true, completion: nil)
//                    return
//                }
//            }
//        } else {
//            print("You should set an appleMerchantId.")
//        }
//    }
//    
}
