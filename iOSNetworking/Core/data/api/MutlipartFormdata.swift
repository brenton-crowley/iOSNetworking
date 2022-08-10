//
//  MutlipartFormdata.swift
//  iOSNetworking
//
//  Created by Brent on 10/8/2022.
//

import Foundation

struct MultipartFormdata {
    
    enum FieldType {
        case text(fieldName: String, value: String), file(fieldName: String, value: Data, fileName: String, mimeType:String)
    }
    
    // Key/Value pair of form field. Key = fieldName, Value = fieldVale as String, Data or anything else
    let fields:[FieldType]
    let boundaryId = UUID()
    
    var lineBreak: String { "\r\n" }
    var boundary: String { "--\(boundaryId)\(lineBreak)" }
    var headerValue: String { "multipart/form-data; boundary=\(boundaryId.uuidString)" }
    var endBoundary: String { "--\(boundaryId)--" }
    
    var httpBody: Data = Data()
    
    init(fields: [FieldType] = []) {
        self.fields = fields
        self.httpBody = makeHTTPBody()
    }
    
    private func makeHTTPBody() -> Data {
        
        // loop through each of the fields
        
        let httpBody = NSMutableData()
        
        for field in self.fields {
            
            switch field {
            case .text(let fieldName, let value):
                httpBody.append(dataForTextfield(fieldName: fieldName, value: value))
            case .file(let fieldName, let value, let fileName, let mimeType):
                httpBody.append(dataForFile(fieldName: fieldName, imageData: value, fileName: fileName, mimeType: mimeType))
            }
            
        }
        
        httpBody.appendString(endBoundary)
        
        return httpBody as Data
    }
    
    private func dataForTextfield(fieldName: String, value: String) -> Data {
        
        var fieldString = boundary
        
        fieldString.append("Content-Disposition: form-data; name=\"\(fieldName)\"\(lineBreak + lineBreak)")
        fieldString.append("\(value + lineBreak)")
        
        let data = fieldString.data(using: .utf8)
        
        return data ?? Data()
    }
    
    private func dataForFile(fieldName: String, imageData: Data, fileName: String, mimeType: String) -> Data {
        
        let data = NSMutableData()
        
        data.appendString(boundary)
        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\(lineBreak)")
        data.appendString("Content-Type: \(mimeType + lineBreak + lineBreak)")
        data.append(imageData)
        data.appendString(lineBreak)
        
        return data as Data
    }
    
}

extension NSMutableData {
    
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) { self.append(data) }
    }
    
}
