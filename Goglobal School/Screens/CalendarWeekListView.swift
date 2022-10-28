//
//  CalendarWeekListView.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/10/22.
//

import SwiftUI

struct CalendarWeekListViewModel: View {
    @StateObject var taskData: BadysittingViewModel = BadysittingViewModel()
    @Namespace var animation
    private let calendar: Calendar
    private let monthDayFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    private static var now = Date()
    @State private var selectDate = Self.now
    var prop: Properties
    init(calendar: Calendar, prop: Properties){
        self.calendar = calendar
        self.monthDayFormatter = DateFormatter(dateFormat: "EEEE, d MMM yyyy", calendar: calendar)
        self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
        self.weekDayFormatter = DateFormatter(dateFormat: "E", calendar: calendar)
        self.prop = prop
    }
   
    var body: some View {
        VStack {
           CalendarWeekListView(
            calendar: calendar,
            prop: prop,
            date: $selectDate,
            content: { date in
                Button(action: {
                    selectDate = date
                    withAnimation {
                        taskData.currentDay = date
                    }
                }){
                    Text("00")
                        .font(.system(size: 13))
                        .padding(10)
                        .foregroundColor(.clear)
                        .overlay(
                            Circle()
                                .fill(Color(weekDayFormatter.string(from: date)))
                                .foregroundColor(.black)
                                .opacity(calendar.isDate(date, inSameDayAs: selectDate) ? 1:0)
                        )
                        .overlay(
                            Text(dayFormatter.string(from: date))
                                .fontWeight(.bold)
                                .foregroundColor(
                                    calendar.isDate(date, inSameDayAs: selectDate) ? .white : calendar.isDateInToday(date) ? .blue : .black
                                )
                        )
                        
                        .overlay(
                            Circle()
                                .stroke(Color(weekDayFormatter.string(from: date)), lineWidth: 1)
                                .opacity(calendar.isDate(date, inSameDayAs: selectDate) ? 0:1)
                        )
                }
            }, header: { date in
                Text("00")
                    .font(.system(size: 13))
                    .padding(10)
                    .foregroundColor(.clear)
                    .overlay(
                        Text(weekDayFormatter.string(from: date))
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                            .foregroundColor(
                                Color(weekDayFormatter.string(from: date))
                            )
                    )
            }, title: { date in
                HStack{
                    Text(monthDayFormatter.string(from: selectDate))
                        .font(.headline)
                        .padding()
                        .foregroundColor(.blue)
                    Spacer()
                }
                .padding(.bottom,6)
            }, weekSwitcher: { date in
                Button {
                    withAnimation {
                        guard let newData = calendar.date(byAdding: .weekOfMonth, value: -1, to: selectDate) else { return }
                        selectDate = newData
                    }
                } label: {
                    Label(
                        title:{ Text("Previous") },
                        icon: { Image(systemName: "chevron.left") }
                        )
                    .labelStyle(IconOnlyLabelStyle())
                    .padding(.horizontal)
                    }
                Button {
                    withAnimation {
                        guard let newData = calendar.date(byAdding: .weekOfMonth, value: 1, to: selectDate) else { return }
                        selectDate = newData
                    }
                } label: {
                    Label(
                        title:{ Text("Previous") },
                        icon: { Image(systemName: "chevron.right") }
                        )
                    .labelStyle(IconOnlyLabelStyle())
                    .padding(.horizontal)
                    }
                }
           )
            ScrollView(.vertical, showsIndicators: false) {
                ReportView()
            }
            
        }
        .onAppear{
            taskData.getAllReports(stuId: "61f8a589f1492ade62731b21")
        }
    }
    
    @ViewBuilder
    func ReportView() -> some View {
        LazyVStack{
            if let tasks = taskData.filteredTasks{
                if tasks.isEmpty{
                    Text("មិនមានទិន្នន័យ!!!")
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                        .fontWeight(.light)
                        .offset(y: prop.isLandscape ? 100 :  300)
                } else {
                    ForEach(tasks, id: \.Id){ task in
                        taskView(task: task)
                    }
                }
            } else {
                ProgressView()
                    .offset(y: 100)
            }
        }
        .onChange(of: taskData.currentDay) { newValue in
            taskData.filterTodayTasks()
        }
    }
    
    func taskView(task: BadysittingModel) -> some View{
        VStack{
            Text("\(convertDate(inputDate: task.Date))")
            Text("Food")
                .padding()
                .frame(maxWidth: .infinity)
                .background(.gray)
            if task.Activity.isEmpty{
                Text("មិនមានទិន្នន័យ!!!")
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                    .fontWeight(.light)
            } else {
                ForEach(Array(task.Food.enumerated()), id: \.element.Title) { item, food in
                    if food.Qty != 0 {
                        VStack(spacing: 20){
                            tasks(imageURL: food.IconSrc, title: food.IconName, body: food.Title, index: item, count: food.Qty)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            
            Text("Activity")
                .padding()
                .frame(maxWidth: .infinity)
                .background(.gray)
            if task.Activity.isEmpty{
                Text("មិនមានទិន្នន័យ!!!")
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                    .fontWeight(.light)
            } else {
                ForEach(Array(task.Activity.enumerated()), id: \.element.Title){ item, active in
                    if active.Qty != 0 {
                        VStack(spacing: 20){
                            tasks(imageURL: active.IconSrc, title: active.IconName, body: active.Title, index: item, count: active.Qty)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    func tasks(imageURL: String, title: String, body: String, index: Int, count: Int) -> some View {
        HStack{
            HStack(spacing: 20){
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .resizable()
                            .frame(width: 30, height: 30)
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 45 , height: 45)
                            )
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 45 , height: 45)
                            )
                    @unknown default:
                        // Since the AsyncImagePhase enum isn't frozen,
                        // we need to add this currently unused fallback
                        // to handle any new cases that might be added
                        // in the future:
                        EmptyView()
                    }
                }
                VStack(alignment:.leading){
                    Text(title)
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                        .listRowBackground(Color.yellow)
                        .foregroundColor(Color(index % 2 == 0 ?"bodyOrange":"bodyBlue"))
                    Text("\(body), ចំនួន: \(count) ")
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                        .listRowBackground(Color.yellow)
                        .foregroundColor(Color(index % 2 == 0 ?"bodyOrange":"bodyBlue"))
                }
            }
            .padding()
            .frame(maxWidth:.infinity,alignment: .leading)
        }
        .frame(maxWidth:.infinity,alignment: .leading)
        .background(Color( index % 2 == 0 ? "LightOrange" : "LightBlue"))
        .cornerRadius(15)
    }
    private func isSameDay(date1: Date, date2: Date)-> Bool {
        let calendar = NSCalendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    private func convertDate(inputDate: String) -> Date{
        let isoDate = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:isoDate)!
        return date
    }
}

struct CalendarWeekListViewModel_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        CalendarWeekListViewModel(calendar: Calendar(identifier: .gregorian), prop: prop)
    }
}

struct CalendarWeekListView <Day: View, Header: View, Title: View,  WeekSwitcher: View>: View {
    private var calendar: Calendar
    @Binding private var date: Date
    private let content: (Date) -> Day
    private let header: (Date) -> Header
    private let title: (Date) -> Title
    private let weekSwitcher: (Date) -> WeekSwitcher
    private let daysInWeek = 7
    var prop: Properties
    init(
        calendar: Calendar,
        prop: Properties,
        date: Binding<Date>,
        @ViewBuilder content: @escaping (Date) -> Day,
        @ViewBuilder header: @escaping (Date) -> Header,
        @ViewBuilder title: @escaping (Date) -> Title,
        @ViewBuilder weekSwitcher: @escaping (Date) -> WeekSwitcher
    ) {
        self.calendar = calendar
        self._date = date
        self.content = content
        self.header = header
        self.title = title
        self.weekSwitcher = weekSwitcher
        self.prop = prop
    }
    
    var body: some View{
        let month = date.startOfMonth(using: calendar)
        let days = makeDays()
        VStack{
            HStack {
                self.title(month)
                self.weekSwitcher(month)
            }
            .padding(.horizontal)
            
            HStack(spacing: prop.isiPhoneS ?  12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18){
                ForEach(days, id: \.self){ date in
                    content(date)
                }
            }
            
            HStack(spacing: prop.isiPhoneS ?  12 : prop.isiPhoneM ? 14 : prop.isiPhoneL ? 16 : 18 ){
                ForEach(days.prefix(daysInWeek), id: \.self, content: header)
            }
            
            Divider()
        }
        .frame(maxWidth:.infinity, alignment: .top)
    }
}
// Helper-
private extension CalendarWeekListView {
    func makeDays()-> [Date]{
        guard
            let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: date),
              let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: firstWeek.end - 1 )
        else {
            return []
        }
        let dateInterval = DateInterval(start: firstWeek.start, end: lastWeek.end)
        return calendar.generateDays(for: dateInterval)
    }
}

private extension Calendar {
    func generateDates(
        for dateInterval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates = [dateInterval.start]
        
        enumerateDates(
            startingAfter: dateInterval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            guard let date = date else  { return }
               
            guard date < dateInterval.end else {
                stop = true
                return
            }
            dates.append(date)
        }
        return dates
    }
    
    func generateDays(for dateInteval: DateInterval) -> [Date] {
        generateDates(for: dateInteval,
                     matching: dateComponents([.hour, .minute, .second], from: dateInteval.start))
    }
}

private extension Date{
    func startOfMonth(using calendar: Calendar) -> Date{
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)
        ) ?? self
    }
}

private extension DateFormatter{
    convenience init(dateFormat: String, calendar: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
        self.locale = Locale(identifier: "en-US")
    }
}
