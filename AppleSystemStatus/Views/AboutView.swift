import SwiftUI
import MessageUI

struct AboutView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    var body: some View {
        VStack {
            Section {
                Image("Logo").resizable().scaledToFit().frame(width: 128, height: 128)
                Text("Apple System Status")
                    .font(.largeTitle)
                Text("1.0")
                    .font(.title)
            }
            Spacer()
            Section {
                Text("Dmytro Morozov").font(.headline)
                if MFMailComposeViewController.canSendMail() {
                    Button(action: {
                        self.isShowingMailView.toggle()
                    }, label: {
                        Image(systemName: "envelope")
                        Text("contact")
                    }).padding()
                }
                HStack {
                    Spacer()
                    Link(destination: URL(string: "https://twitter.com/mdmsua")!, label: {
                        let image = Image("Twitter").resizable().frame(width: 25, height: 25)
                        if colorScheme == .dark {
                            image.colorInvert()
                        } else {
                            image
                        }
                        Text("@mdmsua")
                    })
                    Spacer()
                    Link(destination: URL(string: "https://github.com/mdmsua")!, label: {
                        let image = Image("GitHub").resizable().frame(width: 25, height: 25)
                        if colorScheme == .dark {
                            image.colorInvert()
                        } else {
                            image
                        }
                        Text("mdmsua")
                    })
                    Spacer()
                }
            }.sheet(isPresented: $isShowingMailView) {
                MailView(isShowing: self.$isShowingMailView, result: self.$result)
            }
            Spacer()
            Section {
                Link(destination: URL(string: "https://icons8.com")!, label: {
                    let image = Image("Icons8").resizable().frame(width: 25, height: 25)
                    if colorScheme == .dark {
                        image.colorInvert()
                    } else {
                        image
                    }
                    Text("icons_by")
                })
                Link(destination: URL(string: "https://azure.microsoft.com")!, label: {
                    Image("Azure").resizable().frame(width: 25, height: 25)
                    Text("powered_by")
                })
            }
        }.padding()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
            
            
    }
}
