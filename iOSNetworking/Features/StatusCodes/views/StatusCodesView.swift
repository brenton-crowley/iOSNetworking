//
//  StatusCodesView.swift
//  iOSNetworking
//
//  Created by Brent on 2/8/2022.
//

import SwiftUI

struct StatusCodesView: View {
    
    private struct Constants {
        
        // Labels
        static let segmentedInstruction = "Choose a status code grouping."
        static let pickerInstruction = "Use the picker to select a status code."
        static let labelOffets:CGFloat = 15.0
        
        // message detail labels
        static let noMessageHeader = "Click below to see if the status code contains a message."
        static let messageHeader = "Status code message"
        static let fetchMessageLabelText = "Fetch Message"
        static let fetchMessageSystemIcon = "square.and.arrow.down"
        
        static let statusCodeLabelText = "Status Code: "
        static let statusCodeSystemImage = "number"
        
        static let messageLabelText = "Message: "
        static let messageSystemImage = "message"
        
        static let pickerBgCornerRadius:CGFloat = 20.0
        static let defaultSpacing:CGFloat = 20.0
    }
    
    // MARK: - View
    
    @ObservedObject private var model:StatusCodeViewModel = StatusCodeViewModel()
    
    @State private var statusCodeFilter: StatusCodeFilter = .one
    @State private var statusCodePickerNumber: Int = 000
    
    var statusCode: StatusCode? { model.statusCodes[formattedStatusCode(statusCodePickerNumber)] }
    var message: String? { statusCode?.message }
    
    var body: some View {
        VStack (spacing: .zero ) {
            Group {
                Text(Constants.segmentedInstruction)
                    .offset(y: Constants.labelOffets)
                statusCodesSegments
                Text(Constants.pickerInstruction)
                    .offset(y: Constants.labelOffets)
                statusCodePicker
            }
            .padding()
            messageView
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                UserProfileButton()
            }
        }
    }
    
    // MARK: - Segmented Control
    
    var statusCodesSegments: some View {
        
        Picker("Status Codes Segmented Filter", selection: $statusCodeFilter) {
            
            ForEach(StatusCodeFilter.allCases, id: \.self) { statusCode in
                Text(statusCode.label)
                    .tag(statusCode)
            }
        }
        .pickerStyle(.segmented)
        
    }
    
    // MARK: - Picker Control
    
    var statusCodePicker: some View {
        
        Picker("Status Codes Picker", selection: $statusCodePickerNumber) {
            
            let statusCodeRange:ClosedRange<Int> = statusCodeFilter.range
            
            ForEach(statusCodeRange , id: \.self) { statusCode in
                Text(formattedStatusCode(statusCode))
                    .tag(statusCode)
            }
        }
        .pickerStyle(.wheel)
        .background(
            RoundedRectangle(cornerRadius: Constants.pickerBgCornerRadius)
                .stroke(Color.secondary)
        )
        
    }
    
    // MARK: - Action Body
    
    // Check the StatusCode.codes static dict to look up the key.
    // If the key doesn't exist, show the button.
    // If the key exists, show the stored message.
    // Potentially add an animation.
    var messageView: some View {

        ZStack (alignment: .top) {
            Color.themeBackground
            Group {
                
                if model.isFetching {
                    ProgressView("Fetching Message...")
                } else {
                    if message == nil {
                        fetchMessageButton
                    } else {
                        messageDetail
                    }
                }
                
            }
            .padding()
        }
    }
    
    var messageDetail: some View {
        
        VStack (alignment: .leading, spacing: Constants.defaultSpacing) {
            if let message = message {
                
                messageDetailField(with: Constants.statusCodeLabelText,
                                   systemIconName: Constants.statusCodeSystemImage,
                                   value: formattedStatusCode(statusCodePickerNumber))
                
                messageDetailField(with: Constants.messageLabelText,
                                   systemIconName: Constants.messageSystemImage,
                                   value: message)
            }
        }
    }
    
    @ViewBuilder
    private func messageDetailField(with labelText: String, systemIconName: String, value: String) -> some View {
        HStack {
            Label(labelText, systemImage: systemIconName)
                .foregroundColor(.secondary)
                .font(.caption)
            Spacer()
            Text(value)
                .multilineTextAlignment(.trailing)
        }
    }
    
    var fetchMessageButton: some View {

        VStack {
            Text(Constants.noMessageHeader)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.vertical)
                .multilineTextAlignment(.center)
            Button {
                    // TODO: Make a request to the API and fetch the status code.
                let code = formattedStatusCode(statusCodePickerNumber)
                model.fetchStatusCode(code)
                } label: {
                    Label(Constants.fetchMessageLabelText,
                          systemImage: Constants.fetchMessageSystemIcon)
            }
        }
        
    }
    
    private func formattedStatusCode(_ statusCode: Int) -> String {
        
        let leadingZero = statusCode < 10 ? "0" : ""
        return "\(statusCodeFilter.rawValue)\(leadingZero)\(statusCode)"
    }
    
}

struct StatusCodes_Previews: PreviewProvider {
    static var previews: some View {
        StatusCodesView()
            .nestInNavigationView(selectedTab: Tabs.statusCodes.rawValue)
    }
}
