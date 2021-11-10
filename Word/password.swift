import Foundation
import UIKit

class Password{
    func generatePsd() -> String {
        let lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz"
        let upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let number = "0123456789"
        let specialChar = "$@$#!%?&"

        var s = ""
        for _ in 0 ..< 5 {
            s.append(lowerCaseLetters.randomElement()!)
        }
        for _ in 0 ..< 3 {
            s.append(upperCaseLetters.randomElement()!)
        }
        for _ in 0 ..< 3 {
            s.append(number.randomElement()!)
        }
        for _ in 0 ..< 1 {
            s.append(specialChar.randomElement()!)
        }
        return String(s.shuffled())
    }
    //in the scale of 1-5: Very Weak -> Weak -> Reasonable -> Strong -> very Strong
    func testPwd(pwd: String)-> Int{
//        //has at least 8 digit; contains lower, upper, number and special character
//        let veryStrong = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&]).{8,}$")
//        //strong: does have
//        let strong = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
//        //reasonable: at least 8 digit;
//        let reasonable = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
//        //weak: at least 6 digit; has all lower case or upper case
//        let weak = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z]).{6,}$")
//        let weak2 = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[A-Z]).{6,}$")
        var strength = 0
        let containLowerCase = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z]).{5,}$")
        let containUpperCase = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z]).{5,}$")
        let containNumber = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z]).{5,}$")
        let containSpecialChar = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z]).{5,}$")
        let hasEightDigit = NSPredicate(format: "SELF MATCHES %@ ", "^.{8,}$")
        
        
        if(containLowerCase.evaluate(with: pwd)){
            strength+=1
        }
        if(containUpperCase.evaluate(with: pwd)){
            strength+=1
        }
        if(containNumber.evaluate(with: pwd)){
            strength+=1
        }
        if(containSpecialChar.evaluate(with: pwd)){
            strength+=1
        }
        if(hasEightDigit.evaluate(with: pwd)){
            strength+=1
        }
        
        
        return strength
    }
}
