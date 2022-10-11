//
//  Grade.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 25/8/22.
//
import SwiftUI

struct Grade: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var enrollments: ListStudentViewModel = ListStudentViewModel()
    @StateObject var enrollment: EnrollmentViewModel = EnrollmentViewModel()
    @State var ChoseTitle: String = ""
    @State var chose: Chose = .attendance
    @State var isShow: Bool = false
    @State private var selection: String? = nil
    @State var studentId: String
    @State var colorBlue: String = "LightBlue"
    @State var colorOrg: String = "LightOrange"
    @State var axcessPadding: CGFloat = 0
    @State var userProfileImg: String
    @State var classId: String = ""
    @State var academicYearId: String = ""
    @State var programId: String = ""
    @State var clasLoading: Bool = false
    let gradient = Color("BG")
    let Enrollment: [EnrollmentsViewModel]
    let Student: String
    var parentId: String
    var barTitle: String
    var studentID: String
    var prop: Properties
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        backButtonView(prop: prop, barTitle: barTitle)
    }
    }
    
    var body: some View {
        VStack(spacing: 0){
            Divider()
            HStack{
                Text("ថ្នាក់រៀន \(Student)")
                    .font(.custom("Bayon", size: prop.isiPhoneS ? 12 : prop.isiPhoneM ? 14 : 16))
                Rectangle()
                    .frame(maxHeight: 1)
            }
            .foregroundColor(Color("Blue"))
            .padding(.top)
            .padding(.horizontal)
            .frame(width: .infinity, height: .infinity, alignment: .leading)
            if enrollment.enrollments.isEmpty{
                ZStack{
                    if clasLoading{
                        progressingView(prop: prop)
                    }else{
                        Text("មិនមានទិន្ន័យ!")
                            .foregroundColor(.blue)
                    }
                }
                .onAppear{
                    self.clasLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.clasLoading = false
                    }
                }
            }else{
                VStack(spacing: 0){
                    List(Array(enrollment.enrollments.enumerated()), id: \.element.EnrollmentId){ index, item in
                        Choose( Grade: item.GradeName, Class: item.Classname, Year: item.AcademicYearName, Programme: item.Programme, chose: $chose, isShow: $isShow, ChoseTitle: $ChoseTitle, selection: $selection, ClassID: $classId, AcademicID: $academicYearId, ProgrammeID: $programId, classId: item.ClassId, academicYearId: item.AcademicId, programId: item.ProgrammeId, color: index % 2 == 0 ? colorOrg: colorBlue, prop: prop)
                            .foregroundColor( index % 2 == 0 ?  Color("bodyOrange") : Color("bodyBlue"))
                            .backgroundRemover()
                    }
                    .listStyle(GroupedListStyle())
                    NavigationLink(destination: Choosing(chose: chose, studentId: studentId, barTitle: ChoseTitle, prop: prop, classId: self.classId, academicYearId: self.academicYearId, programId: self.programId), tag: "attendance", selection: $selection) { EmptyView() }
                    NavigationLink(destination: Choosing(chose: chose, studentId: studentId, barTitle: ChoseTitle, prop: prop, classId: self.classId, academicYearId: self.academicYearId, programId: self.programId), tag: "absence", selection: $selection) { EmptyView() }
                    NavigationLink(destination: Choosing(chose: chose, studentId: studentId, barTitle: ChoseTitle, prop: prop, classId: self.classId, academicYearId: self.academicYearId, programId: self.programId), tag: "payment", selection: $selection) { EmptyView() }
                    NavigationLink(destination: Choosing(chose: chose, studentId: studentId, barTitle: ChoseTitle, prop: prop, classId: self.classId, academicYearId: self.academicYearId, programId: self.programId), tag: "score", selection: $selection) { EmptyView() }
                    
                }
            }
           
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .navigationBarTitleDisplayMode(.inline)
            .setBG()
            .onAppear(perform: {
                enrollments.StundentAmount(parentId: parentId)
                enrollment.getEnrollment(studentId: studentId)
            })
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack{
                            AsyncImage(url: URL(string: "https://storage.go-globalschool.com/api\(userProfileImg)"), scale: 2){image in
                                
                                switch  image {
                                    
                                case .empty:
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                        .frame(width: prop.isLandscape ? 30 : (prop.isiPhoneS ? 24 : prop.isiPhoneM ? 24 : 24), alignment: .center)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .cornerRadius(50)
                                        .clipped()
                                        .background(Color.black.opacity(0.2))
                                        .clipShape(Circle())
                                        .padding(-5)
                                        .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20), alignment: .center)
                                case .failure:
                                    Image(systemName: "person.fill")
                                        .padding(2)
                                        .font(.system(size:  prop.isLandscape ? 22 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20)))
                                        .cornerRadius(50)
                                        .background(Color.white)
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .frame(width: prop.isLandscape ? 14 : (prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20), alignment: .center)
                                @unknown default:
                                    fatalError()
                                }
                            }
                        }
                    }
                }
            }
        }

struct Choose: View {
    
    @State var showsheet: Bool = false
    @State var Grade: String
    @State var Class: String
    @State var Year: String
    @State var Programme: String
    @Binding var chose: Chose
    @Binding var isShow: Bool
    @Binding var ChoseTitle: String
    @Binding var selection: String?
    @Binding var ClassID: String
    @Binding var AcademicID: String
    @Binding var ProgrammeID: String
    var classId: String
    var academicYearId: String
    var programId: String
    var color: String
    var prop: Properties
    var body: some View {
        
        HStack(spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
            
            Circle()
                .frame(width: 49, height: 49, alignment: .center)
                .overlay(
                    Image(systemName: "graduationcap.circle.fill")
                        .font(.system(size: 50))
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading){
                HStack(spacing: prop.isiPhoneS ? 3 : prop.isiPhoneM ? 4 : 5){
                    Text(Grade)
                        .listRowBackground(Color.yellow)
                        .font(.custom("Bayon", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .largeTitle))
                    
                    Text(Class)
                        .listRowBackground(Color.yellow)
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .largeTitle))
                }
                Text(Programme)
                    .listRowBackground(Color.yellow)
                    .font(.custom("Kantumruy", size: prop.isiPhoneS ? 10 : prop.isiPhoneM ? 12 : 14, relativeTo: .largeTitle))
            }
        }
        .padding()
        .hLeading()
        .background(Color(color))
        .cornerRadius(15)
        .onTapGesture {
            showsheet.toggle()
        }
        .halfSheet(showSheet: $showsheet) {
            // Half Sheet View...
            ZStack {
                Color.white
                    .frame(width: .infinity, height: .infinity, alignment: .leading)
                VStack(alignment: .leading,spacing: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20){
                    Text("ជ្រើសរើស")
                        .font(.custom("Kantumruy", size: prop.isiPhoneS ? 16 : prop.isiPhoneM ? 18 : 20, relativeTo: .title2))
                        .foregroundColor(Color("Blue"))
                    TabButton(title: "កាលវិភាគសិក្សា", image: "calendar.badge.clock", chose: .attendance, selection: "attendance")
                        .buttonStyle(PlainButtonStyle())
                    TabButton(title: "វត្តមានសិស្ស", image: "checklist", chose: .absence, selection: "absence")
                        .buttonStyle(PlainButtonStyle())
                    //                        TabButton(title: "ប្រតិបត្តិពន្ទុ", image: "newspaper.fill", chose: .score, selection: "score").buttonStyle(PlainButtonStyle())
                    TabButton(title: "ប្រវត្តិបង់ថ្លៃសិក្សា", image: "dollarsign.square.fill", chose: .payment, selection: "payment")
                        .buttonStyle(PlainButtonStyle())
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding()
            }
            .ignoresSafeArea()
        } onEnd: {
            print("")
        }
    }
    @ViewBuilder
    func TabButton(title: String, image: String, chose: Chose, selection: String) -> some View{
        Button {
            self.ProgrammeID = self.programId
            self.AcademicID = self.academicYearId
            self.ClassID = self.classId
            self.chose = chose
            self.showsheet.toggle()
            self.isShow = true
            self.ChoseTitle = title
            self.selection = selection
            
        } label: {
            HStack(spacing: prop.isiPhoneS ? 6 : prop.isiPhoneM ? 8 : 10){
                Image(systemName: image)
                    .font(.title)
                Text(title)
                    .font(.custom("Bayon", size: 20, relativeTo: .title2))
            }
            .foregroundColor(Color("Blue"))
        }
    }
}

struct Grade_Previews: PreviewProvider {
    static var previews: some View {
        let EnrollmentVM = EnrollmentsViewModel(enrollment: GetStudentsByParentsQuery.Data.GetStudentsByParent.Enrollment(_id: ""))
        let prop = Properties(isLandscape: false, isiPad: false, isiPhone: false, isiPhoneS: false, isiPhoneM: false, isiPhoneL: false,isiPadMini: false,isiPadPro: false, isSplit: false, size: CGSize(width:  0, height:  0))
        Grade(studentId: "", userProfileImg: "", Enrollment: [EnrollmentVM], Student: "", parentId: "", barTitle: "",studentID: "", prop: prop)
    }
}

struct ResultView: View {
    var choice: String
    
    var body: some View {
        Text("You chose \(choice)")
    }
}
