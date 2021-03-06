/*
Copyright, everisSL
All rights reserved.
 
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.
 
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/

import UIKit

protocol DetalleListaGrouponViewPresenterInterface: ViewPresenterInterface {
    func reloadInformationInView()
}

class DetalleListaGrouponViewController: UIViewController, ViewInterface {

    // MARK: - IBOutlets
    @IBOutlet weak var detalleTV: UITableView!
    
    
    var presenter: DetalleListaGrouponPresenterViewInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.updateView()
        self.setupTableView()
    }

    private func setupTableView() {
        self.detalleTV.delegate = self
        self.detalleTV.dataSource = self
        self.detalleTV.register(UINib(nibName: CuponCell.defaultReuseIdentifierView, bundle: nil), forCellReuseIdentifier: CuponCell.defaultReuseIdentifierView)
        self.detalleTV.register(UINib(nibName: DescriptorTableViewCell.defaultReuseIdentifierView, bundle: nil), forCellReuseIdentifier: DescriptorTableViewCell.defaultReuseIdentifierView)
        self.detalleTV.register(UINib(nibName: MapTableViewCell.defaultReuseIdentifierView, bundle: nil), forCellReuseIdentifier: MapTableViewCell.defaultReuseIdentifierView)
        self.detalleTV.register(UINib(nibName: LinkTableViewCell.defaultReuseIdentifierView, bundle: nil), forCellReuseIdentifier: LinkTableViewCell.defaultReuseIdentifierView)
    }
    
}

extension DetalleListaGrouponViewController: DetalleListaGrouponViewPresenterInterface {

    func reloadInformationInView() {
        self.detalleTV.reloadData()
    }
}

extension DetalleListaGrouponViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = self.presenter.objectForIndexPath() {
            switch indexPath.row {
            case 0:
                let cellCupon = self.detalleTV.dequeueReusableCell(withIdentifier: CuponCell.defaultReuseIdentifierView) as! CuponCell
                cellCupon.configCell(data: model)
                return cellCupon
            case 1:
                let cellDescriptor = self.detalleTV.dequeueReusableCell(withIdentifier: DescriptorTableViewCell.defaultReuseIdentifierView) as! DescriptorTableViewCell
                cellDescriptor.configCell(model: model)
                return cellDescriptor
            case 2:
                let cellMap = self.detalleTV.dequeueReusableCell(withIdentifier: MapTableViewCell.defaultReuseIdentifierView) as! MapTableViewCell
                cellMap.configCell(model: model)
                return cellMap
            default:
                let cellLink = self.detalleTV.dequeueReusableCell(withIdentifier: LinkTableViewCell.defaultReuseIdentifierView) as! LinkTableViewCell
                cellLink.configCell(model: model)
                cellLink.delegate = self
                return cellLink
            }
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return UITableView.automaticDimension
        case 2:
            return 390
        default:
            return UITableView.automaticDimension
        }
    }
}

extension DetalleListaGrouponViewController: LinkTableViewCellDelegate {
    func sendModelData(_ cell: UITableViewCell, url: String) {
        self.presenter.showWebViewIntoGroupon(data: url)
    }
}
