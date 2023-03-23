//
//  HTTPHeaderContentType.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/16.
//

import Foundation

struct HTTPHeaderContentType {
    
     enum Application: String {
        case X_FixedRecord = "Application/X-FixedRecord" /// 기본형태
        case xml = "X-FixedRecord/xml"
        case xml_external_parsed_entity = "Application/xml-external-parsed-entity"
        case xml_dtd = "Application/xml_dtd"
        case mathtml_xml = "Application/mathtml+xml"
        case xslt_xml = "Application/xslt+xml"
        
        case EDI_X12 = "Application/EDI-X12" /// Defined in RFC 1767
        case EDIFACT = "Application/EDIFACT" /// Defined in RFC 1767
        case javascript = "Application/javascript" /// Defined in RFC 4329
        case octet_stream = "Application/octet_stream" /// 디폴트 미디어 타입은 운영체제 종종 실행파일, 다운로드를 의미
        case ogg = "Application/ogg" /// Defined in RFC 3534
        case x_shockwave_flash = "Application/x-shockwave-flash" /// Adobe Flash files
        case json = "Application/json" /// JavaScript Object Notation JSON; Defined in RFC 4627
        case x_www_form_urlencode = "Application/x-www-form-urlencode" /// HTML Form 형태
    }
        
     enum Audio: String {
        case mpeg = "audio/mpeg" /// MP3 or other MPEG audio
        case x_ms_wma = "audio/x-ms-wma" /// Windows Media Audio;
        case vnd_rn_realaudio = "audio/vnd.rn-realaudio" /// RealAudio; 등등
    }
    
    enum Multipart: String {
        case related = "Multipart/related" /// 기본형태
        case mixed = "Multipart/mixed" /// MIME E-mail;
        case alternative = "Multipart/alternative" /// MIME E-mail;
        case formed_data = "Multipart/data" /// 파일 첨부
    }
        
    enum Text: String {
        case xml = "text/xml"
        case css = "text/css"
        case html = "text/html"
        case javascript = "text/javascript"
        case plain = "text/plain"
    }

}

