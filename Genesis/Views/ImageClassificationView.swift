import CoreML
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Select Image"
        label.numberOfLines = 0
        return label
    }()
    
    private let selectImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Image", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapSelectImage), for: .touchUpInside)
        return button
    }()
    
    private let clearImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear Image", for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(didTapClearImage), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(imageView)
        view.addSubview(selectImageButton)
        view.addSubview(clearImageButton)
    }

    @objc func didTapSelectImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func didTapClearImage() {
        imageView.image = UIImage(systemName: "photo")
        label.text = "Select Image"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(
            x: 20,
            y: view.safeAreaInsets.top,
            width: view.frame.size.width-40,
            height: view.frame.size.width-40)
        label.frame = CGRect(
            x: 20,
            y: view.safeAreaInsets.top+(view.frame.size.width-40)+10,
            width: view.frame.size.width-40,
            height: 100
        )
        selectImageButton.frame = CGRect(
            x: 20,
            y: label.frame.origin.y + label.frame.size.height + 10,
            width: view.frame.size.width-40,
            height: 50
        )
        clearImageButton.frame = CGRect(
            x: 20,
            y: selectImageButton.frame.origin.y + selectImageButton.frame.size.height + 10,
            width: view.frame.size.width-40,
            height: 50
        )
    }

    private func analyzeImage(image: UIImage?) {
        guard let buffer = image?.resize(size: CGSize(width: 224, height: 224))?
                .getCVPixelBuffer() else {
            return
        }

        do {
            let config = MLModelConfiguration()
            let model = try GoogLeNetPlaces(configuration: config)
            let input = GoogLeNetPlacesInput(sceneImage: buffer)

            let output = try model.prediction(input: input)
            let text = output.sceneLabel
            if let probability = output.sceneLabelProbs[text] {
                let percentage = Int(probability * 100)
                label.text = "\(text) (\(percentage)%)"
            } else {
                label.text = text
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }


    // Image Picker

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // cancelled
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        imageView.image = image
        analyzeImage(image: image)
    }
}
