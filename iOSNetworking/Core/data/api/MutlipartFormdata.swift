//
//  MutlipartFormdata.swift
//  iOSNetworking
//
//  Created by Brent on 10/8/2022.
//

import Foundation

struct MultipartFormdata {
    
    /// https://www.donnywals.com/uploading-images-and-forms-to-a-server-using-urlsession/
    ///
    /// The HEADER key value pairing.
    /// Content-Type: multipart/form-data; boundary=--------------------------608687404936096009157798
    ///
    /// ----------------------------608687404936096009157798
    /// Content-Disposition: form-data; name="image"; filename="banana.jpeg"
    /// Content-Type: image/jpeg
    ///
    /// DATA...
    /// ----------------------------608687404936096009157798
    /// Content-Disposition: form-data; name="image_name"
    ///
    /// postman_banana
    /// ----------------------------608687404936096009157798-- // boundaryend
    ///
    ///
    ///
    ///
    
    enum FieldType {
        case text(fieldName: String, value: String)
        case file(fieldName: String, value: Data, fileName: String, mimeType:String)
    }
    
    // Key/Value pair of form field. Key = fieldName, Value = fieldVale as String, Data or anything else
    let fields:[FieldType]
    let boundaryId = UUID()
    
    var lineBreak: String { "\r\n" }
    var boundary: String { "--\(boundaryId)" }
    var endBoundary: String { "--------------------------\(boundaryId)--" }
    
    var header: (key: String, value: String) {
        (key: "Content-Type",
         value: "multipart/form-data; boundary=\(boundaryId.uuidString)")
    }
    
    var httpBody = Data()
    
    init(fields: [FieldType] = []) {
        self.fields = fields
        self.httpBody = makeHTTPBody()
    }
    
    private func makeHTTPBody() -> Data {
        
        // loop through each of the fields
        
        var httpBody = Data()
        
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
        
        /// ----------------------------608687404936096009157798
        /// Content-Disposition: form-data; name="image_name"
        ///
        /// postman_banana
        
        var fieldString = "\(boundary)\(lineBreak)"
        
        fieldString.append("Content-Disposition: form-data; name=\"\(fieldName)\"\(lineBreak + lineBreak)")
        fieldString.append("\(value + lineBreak)")
        
        let data = fieldString.data(using: .utf8)
        
        return data ?? Data()
    }
    
    private func dataForFile(fieldName: String, imageData: Data, fileName: String, mimeType: String) -> Data {
        
        /// ----------------------------608687404936096009157798
        /// Content-Disposition: form-data; name="image"; filename="banana.jpeg"
        /// Content-Type: image/jpeg
        ///
        /// DATA...
        
        var data = Data()
        
        data.appendString("\(boundary)\(lineBreak)")
        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\(lineBreak)")
        data.appendString("Content-Type: \(mimeType + lineBreak + lineBreak)")
        data.append(imageData)
        data.appendString(lineBreak)
        
        return data as Data
    }
    
}
