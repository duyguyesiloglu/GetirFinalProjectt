import UIKit

// Custom UIView for shadow and image setup
class CustomShadowImageView: UIView {
    init(frame: CGRect, backgroundColor: UIColor, shadowColor: UIColor, image: UIImage?) {
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        setupShadow(shadowColor: shadowColor)
        setupImage(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupShadow(shadowColor: UIColor) {
        let shadowLayer = CALayer()
        shadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 4
        shadowLayer.shadowOffset = CGSize(width: 0, height: 4)
        shadowLayer.bounds = bounds
        shadowLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        layer.addSublayer(shadowLayer)
    }
    
    private func setupImage(image: UIImage?) {
        guard let cgImage = image?.cgImage else { return }
        let imageLayer = CALayer()
        imageLayer.contents = cgImage
        imageLayer.bounds = bounds
        imageLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        layer.addSublayer(imageLayer)
    }
}

// Custom UILabel setup
class CustomLabelView: UILabel {
    init(frame: CGRect, text: String, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) {
        super.init(frame: frame)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment // Burada textAlignment parametresini kullanıyoruz
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class PageTwoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "gri")
        
        // 'Add to cart' button-like view setup
        let addToCartButtonView = createAddToCartButtonView()
        let addToCartLabel = createAddToCartLabel()
        
        // Shadowed box view setup
        let shadowedBoxView = createShadowedBoxView()
        
        // Add the views to the view hierarchy
        view.addSubview(addToCartButtonView)
        view.addSubview(addToCartLabel)
        view.addSubview(shadowedBoxView)
        
        // Call your existing function to setup constraints for other views
        let shadowImageViews = [
            CustomShadowImageView(frame: CGRect(x: 30, y: 590, width: 70, height: 60), backgroundColor: .white, shadowColor: .gray, image: UIImage(named: "1")),
            CustomShadowImageView(frame: CGRect(x: 121, y: 590, width: 69, height: 61), backgroundColor: .white, shadowColor: .gray, image: UIImage(named: "2")),
            CustomShadowImageView(frame: CGRect(x: 211, y: 590, width: 69, height: 60), backgroundColor: .white, shadowColor: .gray, image: UIImage(named: "3")),
            CustomShadowImageView(frame: CGRect(x: 300, y: 590, width: 70, height: 60), backgroundColor: .white, shadowColor: .gray, image: UIImage(named: "4"))
        ]
        
        let labelViews = [
            CustomLabelView(frame: CGRect(x: 79, y: 327, width: 191, height: 30), text: "SUSHI", font: UIFont(name: "OpenSans-Bold", size: 20)!, textColor: .black, textAlignment: .center),
               CustomLabelView(frame: CGRect(x: 45, y: 403, width: 291, height: 63), text: "Lorem ipsum dolor sit amet, consectetur scing elit.Nunc vides, quid faciat. Totum id externum est, et quod externum", font: UIFont(name: "OpenSans-Bold", size: 14)!, textColor: .black, textAlignment: .center),
            CustomLabelView(frame: CGRect(x: 29, y: 554, width: 87, height: 21), text: "Ingredients", font: UIFont(name: "OpenSans-Bold", size: 14)!, textColor: .black, textAlignment: .left)
        ]
        
        for view in shadowImageViews + labelViews {
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupConstraints(shadowImageViews: shadowImageViews, labelViews: labelViews)
        
        // Constraints for 'Add to cart' button view
        NSLayoutConstraint.activate([
            addToCartButtonView.widthAnchor.constraint(equalToConstant: 280),
            addToCartButtonView.heightAnchor.constraint(equalToConstant: 40),
            addToCartButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addToCartButtonView.topAnchor.constraint(equalTo: view.topAnchor, constant: 690)
        ])
        
        // Constraints for 'Add to cart' label
        NSLayoutConstraint.activate([
            addToCartLabel.centerXAnchor.constraint(equalTo: addToCartButtonView.centerXAnchor),
            addToCartLabel.centerYAnchor.constraint(equalTo: addToCartButtonView.centerYAnchor)
        ])
        
        // Constraints for shadowed box view
        NSLayoutConstraint.activate([
            shadowedBoxView.widthAnchor.constraint(equalToConstant: 301),
            shadowedBoxView.heightAnchor.constraint(equalToConstant: 391),
            shadowedBoxView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shadowedBoxView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110)
        ])
        
        // Place the '1' image on top of the "SUSHI" label
        let oneImageView = UIImageView(image: UIImage(named: "1"))
        oneImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(oneImageView)

        // Constraints for the '1' image view
        NSLayoutConstraint.activate([
            oneImageView.widthAnchor.constraint(equalToConstant: 200), // Örneğin 20x20 boyutunda bir resim için
            oneImageView.heightAnchor.constraint(equalToConstant: 200), // Örneğin 20x20 boyutunda bir resim için
            oneImageView.centerXAnchor.constraint(equalTo: addToCartButtonView.centerXAnchor),
            oneImageView.bottomAnchor.constraint(equalTo: labelViews[0].topAnchor, constant: -10) // Ayarlamanız gereken sabit değeri ayarlayın
        ])
    }
    
    private func createAddToCartButtonView() -> UIView {
        let buttonView = UIView()
        buttonView.backgroundColor = UIColor(named: "moru")
        buttonView.layer.cornerRadius = 15
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        return buttonView
    }
    
    private func createAddToCartLabel() -> CustomLabelView {
        let label = CustomLabelView(frame: .zero, text: "Add to cart", font: UIFont(name: "OpenSans-Bold", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .semibold), textColor: .white, textAlignment: .center)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createShadowedBoxView() -> CustomShadowImageView {
        let boxView = CustomShadowImageView(frame: .zero, backgroundColor: .white, shadowColor: UIColor.black.withAlphaComponent(0.25), image: nil)
        boxView.translatesAutoresizingMaskIntoConstraints = false
        return boxView
    }
    
    private func setupConstraints(shadowImageViews: [CustomShadowImageView], labelViews: [CustomLabelView]) {
        var constraints = [NSLayoutConstraint]()
        
        for (index, imageView) in shadowImageViews.enumerated() {
            constraints.append(imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(30 + 91 * index)))
            constraints.append(imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 590))
            constraints.append(imageView.widthAnchor.constraint(equalToConstant: imageView.frame.width))
            constraints.append(imageView.heightAnchor.constraint(equalToConstant: imageView.frame.height))
        }
        
        for labelView in labelViews {
            constraints.append(labelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: labelView.frame.minX))
            constraints.append(labelView.topAnchor.constraint(equalTo: view.topAnchor, constant: labelView.frame.minY))
            constraints.append(labelView.widthAnchor.constraint(equalToConstant: labelView.frame.width))
            constraints.append(labelView.heightAnchor.constraint(equalToConstant: labelView.frame.height))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
}
