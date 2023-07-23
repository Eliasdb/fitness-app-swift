//
//  HomeView.swift
//  fitness-app
//
//  Created by Elias on 20/07/2023.
//

import FSCalendar
import SwiftUI

struct HomeView: View {
    @State var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            // Displaying the selected date
            FormattedDate(selectedDate: selectedDate, omitTime: true)
            // Passing the selectedDate as Binding
            CalendarViewRepresentable(selectedDate: $selectedDate)
        }            .navigationTitle("Health")

    }
}



struct CalendarViewRepresentable: UIViewRepresentable {
    func updateUIView(_ uiView: FSCalendar, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Creating a object of FSCalendar to track across the view
    fileprivate var calendar = FSCalendar()
    
    
    // Getting selectedDate as a Binding so that we can update it as
    // user changes their selection
    @Binding var selectedDate: Date
    
    func makeUIView(context: Context) -> FSCalendar {
        // Setting delegate and dateSource of calendar to the
        // values we get from Coordinator
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        calendar.appearance.selectionColor = .gray
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.titleWeekendColor = .gray
        calendar.appearance.titleTodayColor = .systemIndigo
        calendar.appearance.todayColor = UIColor(displayP3Red: 0,
                                                          green: 0,
                                                          blue: 0, alpha: 0)
        calendar.appearance.headerTitleColor = .darkGray
        calendar.appearance.headerTitleFont = .systemFont(
                                                        ofSize: 20,
                                                        weight: .black)
        calendar.appearance.titleFont = .boldSystemFont(ofSize: 18)
        
        calendar.appearance.headerDateFormat = "MMMM"
        calendar.firstWeekday = 2
        calendar.scrollDirection = .vertical
        calendar.clipsToBounds = false
        calendar.scope = .week
        calendar.appearance.headerMinimumDissolvedAlpha = 0.12

        // returning the intialized calendar
        return calendar
    }
    
    class Coordinator: NSObject,
                       FSCalendarDelegate, FSCalendarDataSource {
        // Implementing the didSelect method of FSCalendar
        // this is fired with the new date when user selects a new date
        // in the Calendar UI, we are setting our selectedDate Binding
        // var to this new date when this is triggered
        var parent: CalendarViewRepresentable
        
        
        
        init(_ parent: CalendarViewRepresentable) {
            self.parent = parent
        }
        
        
        func calendar(_ calendar: FSCalendar,
                      didSelect date: Date,
                      at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }
       
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
