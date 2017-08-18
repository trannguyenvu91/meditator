//
//  MDSceneListViewController.swift
//  Mediator
//
//  Created by VuVince on 8/12/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

@objc protocol MDSceneListViewControllerDelegate: NSObjectProtocol {
    func getCurrentMedia() -> MDMedia?
    @objc optional func play(media: MDMedia)
}

class MDSceneListViewController: MDBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnClose: UIBarButtonItem!
    var dataSource: MDTableViewDataSource!
    let viewModel = MDSceneListViewModel()
    weak var delegate: MDSceneListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = MDTableViewDataSource(tableView: tableView,
                                           owner: self,
                                           dataProvider: viewModel.dataProvider,
                                           reusedCellID: "Cell")
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupViews() {
        setBlurBackground()
    }
    
    @IBAction func btnCloseDidClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnImportClicked(_ sender: Any) {
        MDMediaImporter.presentImagePickerVC(fromVC: self, animated: true, completion: nil)
    }

}

extension MDSceneListViewController: MDTableViewDataSourceProtocol {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return max(UIScreen.main.bounds.height / 8.0, UIConstant.minimumSceneRowHeight)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return viewModel.canEditRowAt(indexPath)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return viewModel.editActionsForRowAt(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Play this media
        let media = viewModel.getMedia(at: indexPath)
        delegate?.play?(media: media)
    }
    
}

