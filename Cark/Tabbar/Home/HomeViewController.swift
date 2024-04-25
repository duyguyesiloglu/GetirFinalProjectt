//
//  HomeViewController.swift
//  Cark
//
//  Created by Duygu Yesiloglu on 10.04.2024.
//
import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var gridCollectionView: UICollectionView!
    var sliderCollectionView: UICollectionView!

    let deliveryInfoView = UIView()
    let addressLabel = UILabel()
    let timeLabel = UILabel()
    let dropdownButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gri")

        setupNavigationBarImage()
        configureNavigationBar()
        setupDeliveryInfoView()
        setupSliderCollectionView()
        setupGridCollectionView()
        
        configureBackButton()
    }

    func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = .white
        navigationItem.backBarButtonItem = backItem
    }

    func setupNavigationBarImage() {
        guard let logo = UIImage(named: "getir") else { return }
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        containerView.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 120),
            imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 30)
        ])

        navigationItem.titleView = containerView
    }

    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "moru")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    func setupGridCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing: CGFloat = 10
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing

        let itemsPerRow: CGFloat = 2
        let paddingSpace = spacing * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem

        layout.itemSize = CGSize(width: widthPerItem, height: heightPerItem)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)

        gridCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        gridCollectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "gridCell")
        gridCollectionView.backgroundColor = .clear
        gridCollectionView.translatesAutoresizingMaskIntoConstraints = false
        gridCollectionView.delegate = self
        gridCollectionView.dataSource = self

        view.addSubview(gridCollectionView)

        NSLayoutConstraint.activate([
            gridCollectionView.topAnchor.constraint(equalTo: sliderCollectionView.bottomAnchor, constant: spacing),
            gridCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            gridCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            gridCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -spacing)
        ])
    }




    func setupSliderCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.size.width, height: 200)

        sliderCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        sliderCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        sliderCollectionView.backgroundColor = .clear
        sliderCollectionView.translatesAutoresizingMaskIntoConstraints = false
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        view.addSubview(sliderCollectionView)

        NSLayoutConstraint.activate([
            sliderCollectionView.topAnchor.constraint(equalTo: deliveryInfoView.bottomAnchor, constant: 8),
            sliderCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sliderCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sliderCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func setupDeliveryInfoView() {
        deliveryInfoView.backgroundColor = UIColor(named: "sari")
        deliveryInfoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deliveryInfoView)

        NSLayoutConstraint.activate([
            deliveryInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            deliveryInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            deliveryInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -622), // Adjusted for better positioning
            deliveryInfoView.heightAnchor.constraint(equalToConstant: 50)
        ])

        setupLabelsAndButton()
    }

    func setupLabelsAndButton() {
        addressLabel.text = "Select Your Address"
        addressLabel.textColor = .white
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryInfoView.addSubview(addressLabel)

        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: deliveryInfoView.leadingAnchor, constant: 16),
            addressLabel.centerYAnchor.constraint(equalTo: deliveryInfoView.centerYAnchor)
        ])

        timeLabel.text = "15-20 m"
        timeLabel.textColor = .white
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryInfoView.addSubview(timeLabel)

        NSLayoutConstraint.activate([
            timeLabel.trailingAnchor.constraint(equalTo: deliveryInfoView.trailingAnchor, constant: -16),
            timeLabel.centerYAnchor.constraint(equalTo: deliveryInfoView.centerYAnchor)
        ])

        dropdownButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        dropdownButton.tintColor = .purple
        dropdownButton.translatesAutoresizingMaskIntoConstraints = false
        deliveryInfoView.addSubview(dropdownButton)

        NSLayoutConstraint.activate([
            dropdownButton.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 8),
            dropdownButton.centerYAnchor.constraint(equalTo: deliveryInfoView.centerYAnchor),
            dropdownButton.widthAnchor.constraint(equalToConstant: 24),
            dropdownButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.gridCollectionView {
            return 20 // Izgarada gösterilecek hücre sayısı
        } else {
            return 5 // Slider koleksiyon görünümünde gösterilecek hücre sayısı
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.gridCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! GridCollectionViewCell
            // Izgara hücresi yapılandırması
            cell.backgroundColor = UIColor.clear
            cell.titleLabel.text = "Title \(indexPath.item + 1)"
            
            // Fotoğraf dosya adını al ve hücreye ata
            let imageName = "category\(indexPath.item + 1).png"
            cell.imageView.image = UIImage(named: imageName)
            
            return cell
        } else if collectionView == self.sliderCollectionView {
            // Slider koleksiyon görünümü için hücre oluşturma işlemi
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
            let imageNames = ["aa-2.png", "bb-2.png", "cc-2.png", "dd-2.png", "ee-2.png"]
            cell.imageView.image = UIImage(named: imageNames[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // Grid koleksiyon görünümünde hücre boyutları
           if collectionView == gridCollectionView {
               let itemWidth = (collectionView.bounds.width - 50) / 5
               return CGSize(width: itemWidth, height: itemWidth)
           } else {
               // Diğer koleksiyon görünümleri için varsayılan boyut
               return CGSize(width: collectionView.bounds.width, height: 200)
           }
       }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.gridCollectionView {
            print("Grid item at \(indexPath.item) was tapped.")
            
            let productsViewController = ProViewController()
                   self.navigationController?.pushViewController(productsViewController, animated: true)
        } else {
            print("Slider item at \(indexPath.item) was tapped.")
        }
    }
}
