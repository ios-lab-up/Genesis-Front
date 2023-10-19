import SwiftUI

struct MedicalHistoryForm: View {
    
    enum FocusedField {
        case treatment, indications, dosage, frequencyValue, frequencyUnit, startDate, endDate
    }

    @State private var treatment = ""
    @State private var indications = ""
    @State private var dosage = ""
    @State private var frequencyValue = ""
    @State private var frequencyUnit = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    @FocusState private var fieldFocus: FocusedField?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Treatment Details")) {
                    fields(for: .treatment, .indications)
                }
                
                Section(header: Text("Dosage Details")) {
                    fields(for: .dosage, .frequencyValue, .frequencyUnit)
                }
                
                Section(header: Text("Time Range")) {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                        .focused($fieldFocus, equals: .startDate)
                    
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                        .focused($fieldFocus, equals: .endDate)
                }
                
                Button(action: {}) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Prescription")
        }
    }
    
    private func fields(for fields: FocusedField...) -> some View {
        ForEach(fields, id: \.self) { field in
            TextField(fieldLabel(for: field), text: binding(for: field))
                .focused($fieldFocus, equals: field)
                .textContentType(.name)
                .submitLabel(.next)
        }
    }
    
    private func binding(for field: FocusedField) -> Binding<String> {
        switch field {
        case .treatment: return $treatment
        case .indications: return $indications
        case .dosage: return $dosage
        case .frequencyValue: return $frequencyValue
        case .frequencyUnit: return $frequencyUnit
        default: return .constant("")
        }
    }
    
    private func fieldLabel(for field: FocusedField) -> String {
        switch field {
        case .treatment: return "Treatment"
        case .indications: return "Indications"
        case .dosage: return "Dosage"
        case .frequencyValue: return "Frequency Value"
        case .frequencyUnit: return "Frequency Unit"
        default: return ""
        }
    }
}

struct MedicalHistoryForm_Previews: PreviewProvider {
    static var previews: some View {
        MedicalHistoryForm()
    }
}
