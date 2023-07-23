//
//  FormattedDate.swift
//  Dawn
//
//  Created by Elias on 23/07/2023.
//

import SwiftUI

struct FormattedDate: View {
    var selectedDate: Date
    var omitTime: Bool = false
    var body: some View {
        Text(selectedDate.formatted(date: .abbreviated, time:
              omitTime ? .omitted : .standard))
            .font(.system(size: 23))
            .bold()
            .foregroundColor(Color.gray)
            .padding()
            .animation(.spring(), value: selectedDate)
            .frame(width: 400)
    }
}

struct FormattedDate_Previews: PreviewProvider {
    static var previews: some View {
        FormattedDate(selectedDate: Date())
    }
}
