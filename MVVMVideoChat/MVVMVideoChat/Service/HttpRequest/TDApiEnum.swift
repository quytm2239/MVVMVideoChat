//
//  TDApiEnum.swift
//  TourDe
//
//  Created by Hoang Huynh Man on 4/11/18.
//  Copyright © 2018 Yume-sol. All rights reserved.
//

import Foundation
let NO_EXIST_INT: Int = -999

enum SnsKind: Int {
	case None = -999
    case Twitter = 1
    case Facebook = 2
    case Google = 3
	case LINE = 4
}

enum Sex: Int {
    case Man = 1
    case Woman = 2
}

class ReviewSpotEquipmentParams {
    var token: String?
    var spot_id: Int?
    
    var toilet: Int?
    var parking: Int?
    var accommodation: Int?
    var bath: Int?
    var shower: Int?
    var locker: Int?
    var dressing_room: Int?
    var bicycle_delivery: Int?
    var tourist_information: Int?
    var cycle_rack: Int?
    var bicycle_rental: Int?
    var cycling_guide: Int?
    var tool_rental: Int?
    var floor_pump_rental: Int?
    var mechanic_maintenance: Int?
    
}
