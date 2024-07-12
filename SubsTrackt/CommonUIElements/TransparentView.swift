//
//  TransparentView.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-07-10.
//

import Foundation
import SwiftUI

struct TransparentView: UIViewRepresentable{

    

    
    var removeFilters: Bool=false
    func makeUIView(context: Context) -> TransparentViewHelper {
//        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
//        return view
        return TransparentViewHelper(removeFilters: removeFilters)
    }
    
    func updateUIView(_ uiView: TransparentViewHelper, context: Context) {
//        DispatchQueue.main.async{
//
//        }
    }
}

class TransparentViewHelper: UIVisualEffectView{
    init(removeFilters : Bool){
        super.init(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
        if let backdrop = layer.sublayers?.first{
            if removeFilters{
                backdrop.filters = []
                
            }
            else{
                backdrop.filters?.removeAll(where: {filter in String(describing: filter) != "gaussianBlur"})
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //disable trait changed
    //need to disable traits being updated
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
    }
}
