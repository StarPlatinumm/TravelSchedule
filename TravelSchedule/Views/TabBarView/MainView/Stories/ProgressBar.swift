import SwiftUI

extension CGFloat {
    static let progressBarCornerRadius: CGFloat = 6
    static let progressBarHeight: CGFloat = 6
}

struct ProgressBar: View {
    private let numberOfSections: Int
    private let progress: CGFloat
    
    init(numberOfSections: Int, progress: CGFloat) {
        self.numberOfSections = numberOfSections
        self.progress = progress
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundColor(.white)
                
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: .progressBarHeight
                    )
                    .foregroundColor(.ypBlue)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

private struct MaskView: View {
    private let numberOfSections: Int
    
    init(numberOfSections: Int) {
        self.numberOfSections = numberOfSections
    }
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
            }
        }
    }
}

#Preview {
    ProgressBar(numberOfSections: 5, progress: 0.5)
        .padding()
}
