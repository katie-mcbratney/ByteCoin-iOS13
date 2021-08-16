//
//  RateModel.swift
//  ByteCoin
//
//  Created by Katie McBratney on 8/16/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct RateModel: Decodable {
    let rate: Double
    let asset_id_base: String
    let asset_id_quote: String
}
