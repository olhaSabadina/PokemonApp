//
//  lightningsView.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 11.10.2023.
//

import UIKit

class LightningsView: UIView {

    var color: UIColor
    
    override init(frame: CGRect) {
        self.color = .red
        super.init(frame: frame)
        setupView()
    }
    
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        self.color = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        removeAllSublayers()
        drawRedLight()
        drawGrayLight()
        setupView()
    }
    
    private func setupView() {
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func removeAllSublayers() {
        if let sublayers = self.layer.sublayers {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
    }
    
    private func drawRedLight() {
        let layer = CAShapeLayer()
        let lightning = UIBezierPath()
        layer.frame = .init(x: 0, y: 0, width: 268, height: 596)
        buildLihningByPoints(shape: lightning)
        layer.path = lightning.cgPath
        layer.fillColor = color.withAlphaComponent(0.4).cgColor
        self.layer.addSublayer(layer)
    }
    
    private func drawGrayLight() {
        let layer = CAShapeLayer()
        let lightning = UIBezierPath()
        layer.frame = .init(x: -10, y: -20, width: 268, height: 596)
        buildLihningByPoints(shape: lightning)
        layer.path = lightning.cgPath
        layer.strokeColor = UIColor.gray.withAlphaComponent(0.8).cgColor
        layer.fillColor = .none
        layer.lineWidth = 9
        self.layer.addSublayer(layer)
    }
    
    private func buildLihningByPoints (shape: UIBezierPath) {
        shape.move(to: CGPoint(x: 224, y: 2))
        shape.addLine(to: CGPoint(x: 33, y: 268))
        shape.addCurve(to: .init(x: 40, y: 277),
                           controlPoint1: .init(x: 31, y: 274),
                           controlPoint2: .init(x: 35, y: 279))
        shape.addLine(to: CGPoint(x: 114,y: 265))
        shape.addLine(to: CGPoint(x: 20, y: 393))
        shape.addCurve(to: .init(x: 28, y: 403),
                           controlPoint1: .init(x: 17, y: 398),
                           controlPoint2: .init(x: 23, y: 404))
        shape.addLine(to: CGPoint(x: 89, y: 390))
        shape.addLine(to: CGPoint(x: 0.8, y: 589))
        shape.addCurve(to: .init(x: 8, y: 595),
                           controlPoint1: .init(x: -2, y: 593),
                           controlPoint2: .init(x: 4, y: 598))
        shape.addLine(to: CGPoint(x: 221, y: 336))
        shape.addCurve(to: .init(x: 216, y: 324),
                           controlPoint1: .init(x: 224, y: 332),
                           controlPoint2: .init(x: 222, y: 323))
        shape.addLine(to: CGPoint(x: 153, y: 336))
        shape.addLine(to: CGPoint(x: 267, y: 168))
        shape.addCurve(to: .init(x: 261, y: 160),
                           controlPoint1: .init(x: 269, y: 163),
                           controlPoint2: .init(x: 265, y: 158))
        shape.addLine(to: CGPoint(x: 160, y: 195))
        shape.addLine(to: CGPoint(x: 230, y: 3))
        shape.addCurve(to: .init(x: 224, y: 2),
                           controlPoint1: .init(x: 230, y: 0.5),
                           controlPoint2: .init(x: 225, y: -1))
        shape.close()
    }
}
