//
//  GainFormView.swift
//  Finances
//
//  Created by Aidan Katz on 7/12/23.
//

import SwiftUI

struct GainFormView: View {
    @State private var gain: String = ""
    @State private var category: String = ""
    @State private var notes: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack{
                Text("Add Money")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                Spacer()
                Form {
                    HStack {
                        Text("Category")
                            .foregroundColor(.blue)
                        Spacer()
                        VStack {
                            TextField("", text: $category)
                                .foregroundColor(.blue)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.blue)
                        }
                        .padding(.leading)
                    }
                    .listRowBackground(Color.black)
                    HStack {
                        Text("Gain        ")
                            .foregroundColor(.blue)
                        Spacer()
                        VStack {
                            TextField("", text: $gain)
                                .foregroundColor(.blue)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.blue)
                        }
                        .padding(.leading)
                    }
                    .listRowBackground(Color.black)
                    HStack {
                        Text("Notes     ")
                            .foregroundColor(.blue)
                        Spacer()
                        VStack {
                            TextField("", text: $notes)
                                .foregroundColor(.blue)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.blue)
                        }
                        .padding(.leading)
                    }
                    .listRowBackground(Color.black)
                }
                .scrollContentBackground(.hidden)
                HStack {
                    Spacer()
                    Button("Cancel"){
                        dismiss()
                    }
                    Spacer()
                    Button("Submit"){
                        
                    }
                    Spacer()
                }
            }
            .background(Color.black)
        }
    }
}

struct GainFormView_Previews: PreviewProvider {
    static var previews: some View {
        GainFormView()
    }
}
