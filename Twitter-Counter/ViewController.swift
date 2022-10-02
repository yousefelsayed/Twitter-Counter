//
//  ViewController.swift
//  Twitter-Counter
//
//  Created by Yousef Elsayed on 01/10/2022.
//

import UIKit
import TWTextEditor

class ViewController: UIViewController {
    @IBOutlet  weak var twTextView: TWTextEditorView!
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var twitterLabelCount: UILabel!
    static let maxURLLength = 4096
       static let maxTCOSlugLength = 40
       static let maxTweetLengthLegacy = 140
       static let transformedURLLength = 23
       static let permillageScaleFactor = 1000

    var textView: UITextView? {
        return self.twTextView.textView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.textView?.delegate = self
        self.twTextView?.viewDelegate = self
    }


}

extension ViewController: TWTextEditorViewDelegate {
  
    func textDidChange(_ textView: UITextView) {

        self.counterLabel.text = "\(textView.text.count)"
        
        let counter =  ViewController.remainingCharacterCount(text: textView.text)

        self.twitterLabelCount.text = "\(counter)"
        
    }
}

extension ViewController {
    public static func tweetLength(text: String, transformedURLLength: Int) -> Int {
           // Use Unicode Normalization Form Canonical Composition to calculate tweet text length
           let text = text.precomposedStringWithCanonicalMapping

           if text.isEmpty {
               return 0
           }

           // Remove URLs from text and add t.co length
           var string = text
           var urlLengthOffset = 0
//           let urlEntities = urls(in: text)
//
//           for urlEntity in urlEntities.reversed() {
//               let entity = urlEntity
//               let urlRange = entity.range
//               urlLengthOffset += transformedURLLength
//
//               let mutableString = NSMutableString(string: string)
//               mutableString.deleteCharacters(in: urlRange)
//               string = mutableString as String
//           }

           let len = string.count
           var charCount = len + urlLengthOffset

           if len > 0 {
//               var buffer: [Character] = Array.init(repeating: text, count: len)
////               Array.init(repeating: CharacterSet(), count: len)
//
//
//
//               for index in 0..<len {
//                   let c = tex[index]
//                   if c.isEmoji {
//                       charCount += 2
//                   } else {
//                       charCount += 1
//                   }
//               }
           }

           return charCount
       }

       public static func remainingCharacterCount(text: String) -> Int {
           return self.remainingCharacterCount(text: text, transformedURLLength: transformedURLLength)
       }

       public static func remainingCharacterCount(text: String, transformedURLLength: Int) -> Int {
           return maxTweetLengthLegacy - self.tweetLength(text: text, transformedURLLength: transformedURLLength)
       }

       // MARK: - Private Methods
       internal static let invalidCharacterRegexp = try! NSRegularExpression(pattern: Regexp.TWUInvalidCharactersPattern, options: .caseInsensitive)

       private static let validGTLDRegexp = try! NSRegularExpression(pattern: Regexp.TWUValidGTLD, options: .caseInsensitive)

       private static let validURLRegexp = try! NSRegularExpression(pattern: Regexp.TWUValidURLPatternString, options: .caseInsensitive)

       private static let validDomainRegexp = try! NSRegularExpression(pattern: Regexp.TWUValidDomain, options: .caseInsensitive)

       private static let validTCOURLRegexp = try! NSRegularExpression(pattern: Regexp.TWUValidTCOURL, options: .caseInsensitive)

       private static let validHashtagRegexp = try! NSRegularExpression(pattern: Regexp.TWUValidHashtag, options: .caseInsensitive)

       private static let endHashtagRegexp = try! NSRegularExpression(pattern: Regexp.TWUEndHashTagMatch, options: .caseInsensitive)

       private static let validSymbolRegexp = try! NSRegularExpression(pattern: Regexp.TWUValidSymbol, options: .caseInsensitive)

       private static let validMentionOrListRegexp = try! NSRegularExpression(pattern: Regexp.TWUValidMentionOrList, options: .caseInsensitive)

       private static let validReplyRegexp = try! NSRegularExpression(pattern: Regexp.TWUValidReply, options: .caseInsensitive)

       private static let endMentionRegexp = try! NSRegularExpression(pattern: Regexp.TWUEndMentionMatch, options: .caseInsensitive)

       private static let validDomainSucceedingCharRegexp = try! NSRegularExpression(pattern: Regexp.TWUEndMentionMatch, options: .caseInsensitive)

       private static let invalidURLWithoutProtocolPrecedingCharSet: CharacterSet = {
           CharacterSet.init(charactersIn: "-_./")
       }()

}

extension String {
    var isEmoji: Bool {
        do {
            let range = NSMakeRange(0, self.utf16.count)
            let regex = try NSRegularExpression(pattern: Regexp.emojiPattern, options: [])
            let matches = regex.matches(in: self, options: [], range: range)

            return matches.count == 1
                && matches[0].range.location != NSNotFound
                && NSMaxRange(matches[0].range) <= self.utf16.count
        } catch {
            return false
        }
    }
}

extension Character {
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else {
            return false
        }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    var isCombinedIntoEmoji: Bool {
        unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false
    }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}
