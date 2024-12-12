import SwiftUI

struct CategorySelectionView: View {
    @State private var navigateToBookRecom = false
    @State private var selectedCategory = "Select"
    @State private var monthlyGoal = ""

    let categories = ["Fiction", "Law", "Language Arts & Disciplines", "Psychology", "History", "Social Science", "Commercial", "Biography", "Literary Collections", "Architecture", "Business & Economics", "Philosophy", "Education", "Cooking", "Photography", "Travel"]

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()

                // Logo Image
                Image("binderLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 275, height: 275)
                    .padding(25)

                // Category Selection
                VStack(alignment: .leading, spacing: 10) {
                    Text("Please select categories")
                        .font(.subheadline)
                        .foregroundColor(Color("wordColor"))
                        .padding(.leading, 30)

                    HStack {
                        Picker("Select", selection: $selectedCategory) {
                            ForEach(categories, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())

                        Spacer()
                    }
                    .padding()
                    .background(Color("SelectorColor"))
                    .cornerRadius(15)
                    .padding(.horizontal, 40)
                }

                // Monthly Goal Input
                VStack(alignment: .leading, spacing: 10) {
                    Text("Please set your month goal")
                        .font(.subheadline)
                        .foregroundColor(Color("wordColor"))
                        .padding(.leading, 30)

                    TextField("...books per month", text: $monthlyGoal)
                        .padding()
                        .background(Color("SelectorColor"))
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 40)
                }

                Spacer()

                // Confirm Button
                Button(action: {
                    print("Category: \(selectedCategory), Goal: \(monthlyGoal)")
                    navigateToBookRecom = true
                }) {
                    Text("Confirm")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("buttonColor"))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
                .padding(.horizontal, 40)
                .navigationDestination(isPresented: $navigateToBookRecom) {
                    // to BookRecommendationView
                    BookRecommendationView(selectedCategory: selectedCategory, libraryVM: LibraryViewModel())
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("backgrondColor1").opacity(0.4))
            .ignoresSafeArea()
        }
    }
}

struct CategoriesSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySelectionView()
    }
}
