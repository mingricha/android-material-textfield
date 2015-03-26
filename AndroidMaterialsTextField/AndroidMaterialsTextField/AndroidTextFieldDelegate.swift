import UIKit

class AndroidTextFieldDelegate: UIView, UITextFieldDelegate {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var bottomLine: UIView!
  @IBOutlet weak var informationLabel: UILabel!
  @IBOutlet weak var counterLabel: UILabel!

  // Adroid text field constants
  let kClearKeyActionStringCompare = ""

  // Android text field properties
  var minLength: Int = 0
  var maxLength: Int = 4
  var bottomLineNormalColor = UIColor.grayColor()
  var bottomLineErrorColor = UIColor.redColor()
  var currentTextFieldSize = 0

  // Android text field flags
  var isLengthEnabled: Bool = true
  var isTitleEnabled: Bool = true
  var isHintEnabled: Bool = false

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func awakeFromNib() {
    textField.delegate = self
    self.updateTextFieldWithFlags()
    self.setupTestValues()
  }

  private func setupTestValues() {
    counterLabel.text = self.minLength.description + "/" + self.maxLength.description
    self.titleLabel.text = "Email"
  }

  private func updateTextFieldWithFlags() {
    self.checkIsLengthEnabledFlag()
    self.checkIsTitleEnabledFlag()
    self.checkIsHintEnabledFlag()
  }

  private func checkIsLengthEnabledFlag() {
    if isLengthEnabled {
      self.counterLabel.hidden = false
    } else {
      self.counterLabel.hidden = true
    }
  }

  private func checkIsTitleEnabledFlag() {
    if isTitleEnabled {
      self.titleLabel.hidden = false
    } else {
      self.titleLabel.hidden = true
    }
  }

  private func checkIsHintEnabledFlag() {
    if isHintEnabled {
      self.informationLabel.hidden = false
    } else {
      self.informationLabel.hidden = true
    }
  }

  private func updateCurrentTextFieldSize(range: NSRange, string: String) {
    if (string != kClearKeyActionStringCompare) {
      currentTextFieldSize += countElements(string)
    } else {
      currentTextFieldSize -= range.length
    }
  }

  private func updateCounterLabel(string: String) {
    self.counterLabel.text = currentTextFieldSize.description + "/" + self.maxLength.description
  }

  private func checkLenghtEnabled() {
    if (isLengthEnabled) {
      self.checkLengthAndChangeBottomLine()
    }
  }

  private func checkLengthAndChangeBottomLine() {
    if (currentTextFieldSize > maxLength || currentTextFieldSize < minLength) {
      self.setBottomLineErrorColor()
      self.setCountLabelErrorColor()
    } else {
      self.setBottomLineNormalColor()
      self.setCountLabelNormalColor()
    }
  }

  private func setBottomLineErrorColor() {
    self.bottomLine.backgroundColor = self.bottomLineErrorColor
  }

  private func setBottomLineNormalColor() {
    self.bottomLine.backgroundColor = self.bottomLineNormalColor
  }

  private func setCountLabelErrorColor() {
    self.counterLabel.textColor = UIColor.redColor()
  }

  private func setCountLabelNormalColor() {
    self.counterLabel.textColor = UIColor.grayColor()
  }

  // MARK: - TextField Delegate Methods

  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    self.updateCurrentTextFieldSize(range, string: string)
    self.updateCounterLabel(string)
    self.checkLenghtEnabled()

    return true
  }
}
