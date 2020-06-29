//
//  PublishPresetTableViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 04/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit
import MobileCoreServices

class PublishPresetTableViewController: UITableViewController {
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var addDNGButton: UIButton!
    @IBOutlet var checkMarksImageViews: [UIImageView]!

    let feedBackAlertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
    var dngPath: String?

    enum CheckMark {
        static let dng = 2
        static let images = 3
    }

    let dao = ImagesAddedCollectionViewDAO()
    var collectionViewDelegate: ImagesAddedCollectionViewDelegate?
    var collectionViewDataSource: ImagesAddedCollectionViewDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    private func configureTableView() {
        imagesCollectionView.register(UINib(nibName: Identifier.imageAddedCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Identifier.imageAddedCollectionViewCell)
        imagesCollectionView.register(UINib(nibName: Identifier.addImageCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Identifier.addImageCollectionViewCell)

        tableView.tableFooterView = UIView(frame: .zero)

        collectionViewDelegate = ImagesAddedCollectionViewDelegate(withDAO: dao)
        collectionViewDataSource = ImagesAddedCollectionViewDataSource(withDAO: dao, andImagesHandlerDelegate: self)

        imagesCollectionView.delegate = collectionViewDelegate
        imagesCollectionView.dataSource = collectionViewDataSource

        imagesCollectionView.reloadData()
    }

    @IBAction func textChanged(_ sender: UITextField) {
        guard let textField = textFields.first(where: { $0 == sender }),
            let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }

        if !text.isEmpty {
            setCheckMarkOn(forIndex: textField.tag)
        } else {
            setCheckMarkOff(forIndex: textField.tag)
        }
    }

    private func setCheckMarkOn(forIndex index: Int) {
        checkMarksImageViews[index].image = UIImage(systemName: "checkmark.circle.fill")
        checkMarksImageViews[index].alpha = 1.0
    }

    private func setCheckMarkOff(forIndex index: Int) {
        checkMarksImageViews[index].image = UIImage(systemName: "checkmark.circle")
        checkMarksImageViews[index].alpha = 0.4
    }
}

extension PublishPresetTableViewController: ImagesHandlerDelegate {

    @IBAction func addDNGButtonTouched(_ sender: UIButton) {
        let documentPickerController = UIDocumentPickerViewController(documentTypes: [kUTTypeData as String], in: .import)
        documentPickerController.allowsMultipleSelection = false
        documentPickerController.delegate = self
        present(documentPickerController, animated: true, completion: nil)
    }
    
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }

    func removeImage(_ image: UIImage) {
        let index = dao.images.index(of: image)
        dao.images.remove(image)
        dao.imagesLinks.removeObject(at: index)
        imagesCollectionView.deleteItems(at: [IndexPath(row: index + 1, section: 0)])

        if dao.images.count == 0 {
            setCheckMarkOff(forIndex: CheckMark.images)
        }
    }
}

extension PublishPresetTableViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let url = info[.imageURL] as? URL,
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) {

            self.dao.images.add(image)
            self.dao.imagesLinks.add(url.absoluteString)
            let row = self.dao.images.count - 1
            self.imagesCollectionView.insertItems(at: [IndexPath(row: row + 1, section: 0)])
            self.dismiss(animated: true, completion: nil)

            setCheckMarkOn(forIndex: CheckMark.images)
        }
    }
}

extension PublishPresetTableViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {

        guard let url = urls.first,
            let fileExtension = url.absoluteString.components(separatedBy: ".").last,
        fileExtension.lowercased() == "dng" else { return }

        dngPath = url.absoluteString

            addDNGButton.tintColor = .black
        addDNGButton.setBackgroundImage(UIImage(systemName: "doc"), for: .normal)

        setCheckMarkOn(forIndex: CheckMark.dng)
    }

    @IBAction func publishPreset() {
        guard let name = textFields[0].text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let description = textFields[1].text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let dngPath = self.dngPath,
            dao.images.count > 0,
            let imagesLinks = self.dao.imagesLinks as? [String],
            let user = DAO.shared.user else {
                feedBackAlertController.title = "Preencha todos os campos para continuar"
                let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                if feedBackAlertController.actions.isEmpty {
                    feedBackAlertController.addAction(ok)
                }
                present(feedBackAlertController, animated: true, completion: nil)
                return
        }

        let artist = Artist(id: user.id, name: user.name, about: "", profileImageLink: user.profileImageUrl?.absoluteString ?? "")
        let preset = Preset(name: name,
                            artist: artist,
                            description: description,
                            dngPath: dngPath,
                            imagesLinks: imagesLinks)

        preset.setPrice(to: 0.0)

        feedBackAlertController.title = "Carregando..."
        present(feedBackAlertController, animated: true, completion: nil)

        DAO.shared.publishPreset(preset) { [weak self] success in
            let ok = UIAlertAction(title: "OK", style: .cancel) { _ in
                self?.dismiss(animated: true, completion: nil)
            }
            DispatchQueue.main.async {
                if success { DAO.shared.loadAllPresets() }
                self?.feedBackAlertController.title = success ? "Sucesso!" : "Algo deu errado :("
                if self?.feedBackAlertController.actions.isEmpty ?? false {
                    self?.feedBackAlertController.addAction(ok)
                }
            }
        }
    }

    @IBAction func cancelButtonTouched(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
