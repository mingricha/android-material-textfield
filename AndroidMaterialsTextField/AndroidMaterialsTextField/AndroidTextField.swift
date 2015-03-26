import UIKit

@IBDesignable class AndroidTextField: UIView {

  var view: UIView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.xibSetup()
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    self.backgroundColor = UIColor.redColor()
    self.xibSetup()
  }

 func xibSetup() {
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
    addSubview(view)
  }

  func loadViewFromNib() -> UIView {
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib = UINib(nibName: "AndroidTextField", bundle: bundle)
    let view = nib.instantiateWithOwner(self, options: nil)[0] as UIView

    return view
  }
}
