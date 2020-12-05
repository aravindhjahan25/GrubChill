//
//  MyOrderTableViewCell.swift
//  GrubChill
//
//  Created by Bharath Kumar on 22/11/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit

class MyOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var DeliveryType: UILabel!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var paymentType: UILabel!
    @IBOutlet weak var itemId: UILabel!
    @IBOutlet weak var totalPrice: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(itemSingle: MyOrderData) {
        orderDate.text = itemSingle.order_created_at ?? ""
        DeliveryType.text = "\(itemSingle.delivery_method ?? "")"
        orderId.text = itemSingle.orderid ?? ""
        paymentType.text = "\(itemSingle.payment_type ?? "")"
        itemId.text = "\(itemSingle.items?.count ?? 0)"
        totalPrice.text = "$ \(itemSingle.total ?? 0)"
    }
}
