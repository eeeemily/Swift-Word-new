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
        var strength = 0
        let containLowerCase = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z]).{4,}$")
        let containUpperCase = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[A-Z]).{4,}$")
        let containNumber = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[0-9]).{4,}$")
        let containSpecialChar = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[$@$#!%*?&]).{4,}$")
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
    
    func getColor(strenth: Int)-> UIColor{
        switch strenth {
        case 5:
            return UIColor(red: 56/255.0, green: 124/255.0, blue: 68/255.0, alpha: 1)
        case 4:
            return UIColor(red: 133/255.0, green: 187/255.0, blue: 101/255.0, alpha: 1)
        case 3:
            return UIColor(red: 154/255.0, green: 202/255.0, blue: 60/255.0, alpha: 1)
        case 2:
            return UIColor(red: 250/255.0, green: 128/255.0, blue: 114/255.0, alpha: 1)
        case 1:
            return UIColor(red: 237/255.0, green: 41/255.0, blue: 57/255.0, alpha: 1)
        default:
            return UIColor.black //should never happen with data added after using model 2
        }
        
    }
}
