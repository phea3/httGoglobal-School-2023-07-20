//
//  CalendarWeekListView.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/10/22.
//

import SwiftUI
import TextFieldAlert

struct CalendarWeekListViewModel: View {
    @StateObject var taskData: BadysittingViewModel = BadysittingViewModel()
    @State var loadingScreen: Bool = false
    @State var currentProgress: CGFloat = 0
    @State var checkbox: Bool = false
    @State var parentComment: String = ""
    @State var parentAlert = false
    @Namespace var animation
    private let calendar: Calendar
    private let monthDayFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    private static var now = Date()
    @State private var selectDate = Self.now
    var prop: Properties
    var stuId: String
    init(calendar: Calendar, prop: Properties, stuId: String){
        self.calendar = calendar
        self.monthDayFormatter = DateFormatter(dateFormat: "EEEE, d MMM yyyy", calendar: calendar)
        self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
        self.weekDayFormatter = DateFormatter(dateFormat: "E", calendar: calendar)
        self.prop = prop
        self.stuId = stuId
    }
   
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
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
                    
                    VStack(spacing: 0){
                        ReportView()
                            .padding(.bottom, 60)
                    }
                }
            }
            VStack{
                if loadingScreen{
                    ZStack{
                        Color("BG")
                            .frame(width: .infinity, height: .infinity)
                            .ignoresSafeArea()
                        VStack{
                            ProgressView(value: currentProgress, total: 1000)
                            Spacer()
                                .onAppear{
                                    self.currentProgress = 250
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                                        self.currentProgress = 500
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        self.currentProgress = 750
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                                        self.currentProgress = 1000
                                    }
                                }
                        }
                    }
                }
            }
        }
        .onAppear{
            self.loadingScreen = true
            taskData.getAllReports(stuId: self.stuId)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                taskData.filterTodayTasks()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.loadingScreen = false
            }
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
            HStack{
                Text("អាហារ/Food")
                    .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                Rectangle()
                    .frame(maxHeight: 1)
            }
            .foregroundColor(Color("Blue"))
            .padding(.top)
            .frame(width: .infinity, height: .infinity, alignment: .leading)
            if task.Activity.isEmpty{
                Text("មិនមានទិន្នន័យ!!!")
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                    .fontWeight(.light)
            } else {
                ForEach(Array(task.Food.enumerated()), id: \.element.Title) { item, food in
                    if food.Qty != 0 {
                        VStack(spacing: 30){
                            tasks(imageURL: food.IconSrc, title: food.IconName, body: food.Title, index: item, count: food.Qty)
                        }
                    }
                }
            }
            HStack{
                Text("សកម្មភាព")
                    .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                Rectangle()
                    .frame(maxHeight: 1)
            }
            .foregroundColor(Color("Blue"))
            .padding(.top)
            .frame(width: .infinity, height: .infinity, alignment: .leading)
            if task.Activity.isEmpty{
                Text("មិនមានទិន្នន័យ!!!")
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                    .fontWeight(.light)
            } else {
                ForEach(Array(task.Activity.enumerated()), id: \.element.Title){ item, active in
                    if active.Qty != 0 {
                        VStack(spacing: 30){
                            tasksAction(imageURL: active.IconSrc, title: active.IconName, body: active.Title, index: item, count: active.Qty)
                        }
                    }
                }
            }
            
            HStack{
                Text("នៅផ្ទះ/At home")
                    .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                Rectangle()
                    .frame(maxHeight: 1)
            }
            .foregroundColor(Color("Blue"))
            .padding(.top)
            .frame(width: .infinity, height: .infinity, alignment: .leading)
            
            HStack(spacing: 20){
                VStack(alignment:.leading){
                    HStack{
                        Image("house")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        Text("ធម្មតា/Normal :")
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                            .foregroundColor(Color("bodyBlue"))
                        
                        Button(action:
                                {
                            self.checkbox.toggle()
                        }) {
                            HStack(alignment: .center, spacing: 10) {
                                Image(systemName: self.checkbox ? "checkmark.square" : "square")
                                    .font(.system(size: 20))
                                    .padding(.bottom, 5)
                                    .foregroundColor(Color("bodyBlue"))
                            }
                        }
                    }
                    HStack{
                        Text("មតិមាតាបិតា Parents’ Comment :")
                            .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                            .foregroundColor(Color("bodyBlue"))
                        Spacer()
                        Button {
                            self.parentAlert = true
                        } label: {
                            Text("បញ្ចូល")
                                .padding(10)
                                .background(.blue)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                        .textFieldAlert(
                                   title: "មតិមាតាបិតា Parents’ Comment :",
                                   textFields: [
                                       .init(text: $parentComment)
                                   ],
                                   actions: [
                                       .init(title: "OK")
                                   ],
                                   isPresented: $parentAlert
                               )
                        
                    }
                    Text("\(parentComment)")
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .frame(maxWidth:.infinity,alignment: .leading)
            .background(Color("LightBlue"))
            .cornerRadius(15)
            
            HStack{
                Text("សូមមាតាបិតាជួយដាក់បន្ថែមឱ្យកូន៖")
                    .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                Rectangle()
                    .frame(maxHeight: 1)
            }
            .foregroundColor(Color("Blue"))
            .padding(.top)
            .frame(width: .infinity, height: .infinity, alignment: .leading)
            VStack(alignment:.leading){
                ForEach(taskData.allReports, id: \.Id){ item in
                    VStack{
                        ForEach(item.ParentsRequest, id: \.self){ img in
                            HStack(spacing: 20){
                                Image(img ?? "")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Text(img ?? "")
                                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14))
                                    .foregroundColor(Color("bodyOrange"))
                            }
                            .padding()
                            .frame(maxWidth:.infinity,alignment: .leading)
                            .background(Color("LightOrange"))
                            .cornerRadius(15)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    func tasks(imageURL: String, title: String, body: String, index: Int, count: Int) -> some View {
        HStack{
            HStack(spacing: 20){
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 50)
                           
                    case .success(let image):
                        image.resizable()
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                            .onAppear{
                                self.loadingScreen = false
                            }
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 45 , height: 45)
                            )
                            .onAppear{
                                self.loadingScreen = false
                            }
                    @unknown default:
                        // Since the AsyncImagePhase enum isn't frozen,
                        // we need to add this currently unused fallback
                        // to handle any new cases that might be added
                        // in the future:
                        EmptyView()
                    }
                }
                VStack(alignment:.leading){
                    Text(body)
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                        .listRowBackground(Color.yellow)
                        .foregroundColor(Color(index % 2 == 0 ?"bodyOrange":"bodyBlue"))
                    Text("បរិមាណ/Quantity: \(count) ")
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
    func tasksAction(imageURL: String, title: String, body: String, index: Int, count: Int) -> some View {
        HStack{
            HStack(spacing: 20){
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 50)
                           
                    case .success(let image):
                        image.resizable()
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                            .onAppear{
                                self.loadingScreen = false
                            }
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 45 , height: 45)
                            )
                            .onAppear{
                                self.loadingScreen = false
                            }
                    @unknown default:
                        // Since the AsyncImagePhase enum isn't frozen,
                        // we need to add this currently unused fallback
                        // to handle any new cases that might be added
                        // in the future:
                        EmptyView()
                    }
                }
                VStack(alignment:.leading){
                    Text(body)
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .body))
                        .listRowBackground(Color.yellow)
                        .foregroundColor(Color(index % 2 == 0 ?"bodyOrange":"bodyBlue"))
                    Text("ចំនួនដង/Times: \(count) ")
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
    
    private func convertDater(inputDate: String) -> String{
        let isoDate = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:isoDate)!
        let stringDateFormatter = DateFormatter()
        stringDateFormatter.dateFormat = "HH"
        let stringDate = stringDateFormatter.string(from: date)
        return stringDate
    }
}

struct CalendarWeekListViewModel_Previews: PreviewProvider {
    static var previews: some View {
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        CalendarWeekListViewModel(calendar: Calendar(identifier: .gregorian), prop: prop, stuId: "")
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
        self.locale = Locale(identifier: "en_US_POSIX")
    }
}
