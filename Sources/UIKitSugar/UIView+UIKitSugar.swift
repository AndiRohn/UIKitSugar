import UIKit

public extension UIView {
  /// Convenience method that both adds a subview and sets the subview's `translatesAutoresizingMaskIntoConstraints` property.
  func addSubview(_ view: UIView, subviewTranslatesAutoresizingMaskIntoConstraints: Bool) {
    view.translatesAutoresizingMaskIntoConstraints = subviewTranslatesAutoresizingMaskIntoConstraints
    addSubview(view)
  }
  
  /// Returns a collection of Auto Layout constraints for pinning the receiver equal to the edges of a layout guide.
  ///
  /// - Parameter layoutGuide The layout guide for the constraints to make the receiver relative to.
  /// - Parameter edges The edges to make the constraints for.
  /// - Parameter insets The constant value to inset the constraints.
  func constraints(equalTo layoutGuide: DirectionalEdgesConstrainable,
                   edges: NSDirectionalRectEdge,
                   insets: NSDirectionalEdgeInsets = .zero) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    
    if edges.contains(.top) {
      constraints.append(topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top))
    }
    if edges.contains(.leading) {
      constraints.append(leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: insets.leading))
    }
    if edges.contains(.bottom) {
      constraints.append(bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom))
    }
    if edges.contains(.trailing) {
      constraints.append(trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -insets.trailing))
    }
    
    return constraints
  }
  
  /// Returns the first ancestor superview that is a type of `kind` and satisfies the `where` clause.
  func firstSuperview<T: UIView>(ofKind kind: T.Type, where block: ((T) -> Bool)? = nil) -> T? {
    var view: UIView? = self
    while view != nil {
      view = view?.superview
      guard let view = view as? T else { continue }
      guard let block = block else { return view }
      if block(view) {
        return view
      }
    }
    return nil
  }
}

public protocol DirectionalEdgesConstrainable {
  var leadingAnchor: NSLayoutXAxisAnchor { get }
  var trailingAnchor: NSLayoutXAxisAnchor { get }
  var topAnchor: NSLayoutYAxisAnchor { get }
  var bottomAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: DirectionalEdgesConstrainable {}
extension UILayoutGuide: DirectionalEdgesConstrainable {}
