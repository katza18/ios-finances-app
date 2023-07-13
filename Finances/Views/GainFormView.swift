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
    
    var body: some View {
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
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.blue)
                            .padding(.leading)
                    }
                }
                .listRowBackground(Color.black)
                HStack {
                    Text("Gain")
                        .foregroundColor(.blue)
                    Spacer()
                    VStack {
                        TextField("", text: $gain)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.blue)
                            .padding(.leading)
                    }
                }
                .listRowBackground(Color.black)
                HStack {
                    Text("Notes")
                        .foregroundColor(.blue)
                    Spacer()
                    VStack {
                        TextField("", text: $notes)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.blue)
                            .padding(.leading)
                    }
                }
                .listRowBackground(Color.black)
            }
            .scrollContentBackground(.hidden)
            HStack {
                Spacer()
                Button("Submit"){
                    
                }
                Spacer()
                Button("Cancel"){
                    
                }
                Spacer()
            }
        }
        .background(Color.black)
    }
}

struct GainFormView_Previews: PreviewProvider {
    static var previews: some View {
        GainFormView()
    }
}
