//
//  SplashScreen.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 13/09/22.
//

import SwiftUI

struct SplashScreen: View {
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundImg
            cardImg
            
        }.ignoresSafeArea()
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

extension SplashScreen {
    private var backgroundImg: some View {
        Image("bgsplash").resizable()
    }
    
    private var cardImg: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Image("splashimg")
                .resizable()
                .frame(width: width, height: 400)
                .padding(.top, 40)
                .padding(.leading, 12)
            
            Spacer()
            
            logoAndText
        }
    }
    
    private var logoAndText: some View {
        HStack {
            Image("Logo")
                .resizable()
                .frame(width: 32, height: 32)
            Text("QuickNotes")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(.bottom, 30)
    }
}
