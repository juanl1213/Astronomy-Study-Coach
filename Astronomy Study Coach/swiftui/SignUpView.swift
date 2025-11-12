//
//  SignUpView.swift
//  Astronomy Study Coach
//
//  Sign up screen matching the React application design
//

import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var agreedToTerms: Bool = false
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var onNavigate: ((String) -> Void)?
    var onSignUp: ((String, String) -> Void)?
    
    var body: some View {
        ZStack {
            // Background
            Color.background
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    // Logo Section
                    VStack(spacing: Spacing.md) {
                        // Star Logo
                        ZStack {
                            RoundedRectangle(cornerRadius: CornerRadius.lg)
                                .fill(LinearGradient.primaryGradient)
                                .frame(width: 64, height: 64)
                                .logoShadow()
                            
                            Image(systemName: "star.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, Spacing.sm)
                        
                        // Welcome Text
                        Text("Join the Journey")
                            .font(.appTitle)
                            .foregroundStyle(LinearGradient.textGradient)
                        
                        Text("Create your account and start exploring the cosmos")
                            .font(.appBody)
                            .foregroundColor(.mutedForeground)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, Spacing.xl)
                    
                    // Sign Up Card
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        // Card Header
                        VStack(alignment: .leading, spacing: Spacing.xs) {
                            Text("Create Account")
                                .font(.appHeading)
                                .foregroundColor(.foreground)
                            
                            Text("Sign up to access interactive astronomy lessons and quizzes")
                                .font(.appCaption)
                                .foregroundColor(.mutedForeground)
                        }
                        .padding(.bottom, Spacing.sm)
                        
                        // Form
                        VStack(spacing: Spacing.md) {
                            // Name Field
                            VStack(alignment: .leading, spacing: Spacing.xs) {
                                Text("Full Name")
                                    .font(.appBody)
                                    .foregroundColor(.foreground)
                                
                                HStack {
                                    Image(systemName: "person")
                                        .foregroundColor(.mutedForeground)
                                        .frame(width: 20)
                                    
                                    TextField("Carl Sagan", text: $name)
                                        .textContentType(.name)
                                        .foregroundColor(.foreground)
                                }
                                .padding(Spacing.md)
                                .background(Color.inputBackground)
                                .cornerRadius(CornerRadius.md)
                                .overlay(
                                    RoundedRectangle(cornerRadius: CornerRadius.md)
                                        .stroke(Color.border, lineWidth: 1)
                                )
                            }
                            
                            // Email Field
                            VStack(alignment: .leading, spacing: Spacing.xs) {
                                Text("Email")
                                    .font(.appBody)
                                    .foregroundColor(.foreground)
                                
                                HStack {
                                    Image(systemName: "envelope")
                                        .foregroundColor(.mutedForeground)
                                        .frame(width: 20)
                                    
                                    TextField("astronomer@space.edu", text: $email)
                                        .textContentType(.emailAddress)
                                        .keyboardType(.emailAddress)
                                        .autocapitalization(.none)
                                        .foregroundColor(.foreground)
                                }
                                .padding(Spacing.md)
                                .background(Color.inputBackground)
                                .cornerRadius(CornerRadius.md)
                                .overlay(
                                    RoundedRectangle(cornerRadius: CornerRadius.md)
                                        .stroke(Color.border, lineWidth: 1)
                                )
                            }
                            
                            // Password Field
                            VStack(alignment: .leading, spacing: Spacing.xs) {
                                Text("Password")
                                    .font(.appBody)
                                    .foregroundColor(.foreground)
                                
                                HStack {
                                    Image(systemName: "lock")
                                        .foregroundColor(.mutedForeground)
                                        .frame(width: 20)
                                    
                                    SecureField("••••••••", text: $password)
                                        .textContentType(.newPassword)
                                        .foregroundColor(.foreground)
                                }
                                .padding(Spacing.md)
                                .background(Color.inputBackground)
                                .cornerRadius(CornerRadius.md)
                                .overlay(
                                    RoundedRectangle(cornerRadius: CornerRadius.md)
                                        .stroke(Color.border, lineWidth: 1)
                                )
                                
                                Text("Must be at least 8 characters")
                                    .font(.appSmall)
                                    .foregroundColor(.mutedForeground)
                            }
                            
                            // Confirm Password Field
                            VStack(alignment: .leading, spacing: Spacing.xs) {
                                Text("Confirm Password")
                                    .font(.appBody)
                                    .foregroundColor(.foreground)
                                
                                HStack {
                                    Image(systemName: "lock")
                                        .foregroundColor(.mutedForeground)
                                        .frame(width: 20)
                                    
                                    SecureField("••••••••", text: $confirmPassword)
                                        .textContentType(.newPassword)
                                        .foregroundColor(.foreground)
                                }
                                .padding(Spacing.md)
                                .background(Color.inputBackground)
                                .cornerRadius(CornerRadius.md)
                                .overlay(
                                    RoundedRectangle(cornerRadius: CornerRadius.md)
                                        .stroke(Color.border, lineWidth: 1)
                                )
                            }
                            
                            // Terms Checkbox
                            HStack(alignment: .top, spacing: Spacing.sm) {
                                Button(action: {
                                    agreedToTerms.toggle()
                                }) {
                                    Image(systemName: agreedToTerms ? "checkmark.square.fill" : "square")
                                        .foregroundColor(agreedToTerms ? .indigo600 : .mutedForeground)
                                        .font(.system(size: 20))
                                }
                                
                                Text("I agree to the Terms of Service and Privacy Policy")
                                    .font(.appSmall)
                                    .foregroundColor(.mutedForeground)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.top, Spacing.xs)
                            
                            // Create Account Button
                            Button(action: {
                                handleSignUp()
                            }) {
                                HStack {
                                    Text(isLoading ? "Creating account..." : "Create Account")
                                        .font(.appBody)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 16))
                                }
                                .foregroundColor(.white)
                                .padding(Spacing.md)
                                .frame(maxWidth: .infinity)
                                .background(LinearGradient.primaryGradient)
                                .cornerRadius(CornerRadius.md)
                            }
                            .disabled(isLoading || !isFormValid)
                            .opacity((isLoading || !isFormValid) ? 0.6 : 1.0)
                            .padding(.top, Spacing.sm)
                        }
                        
                        // Separator
                        HStack {
                            Rectangle()
                                .fill(Color.border)
                                .frame(height: 1)
                        }
                        .padding(.vertical, Spacing.md)
                        
                        // Sign In Link
                        HStack {
                            Text("Already have an account?")
                                .font(.appSmall)
                                .foregroundColor(.mutedForeground)
                            
                            Button(action: {
                                onNavigate?("login")
                            }) {
                                Text("Sign in")
                                    .font(.appSmall)
                                    .fontWeight(.medium)
                                    .foregroundColor(.indigo400)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, Spacing.lg)
                    }
                    .padding(Spacing.lg)
                    .background(Color.cardBackground)
                    .cornerRadius(CornerRadius.lg)
                    .overlay(
                        RoundedRectangle(cornerRadius: CornerRadius.lg)
                            .stroke(Color.border, lineWidth: 1)
                    )
                    .cardShadow()
                }
                .padding(Spacing.md)
                .frame(maxWidth: 500)
            }
        }
        .alert("Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        !confirmPassword.isEmpty &&
        password == confirmPassword &&
        password.count >= 8 &&
        agreedToTerms
    }
    
    private func handleSignUp() {
        guard password == confirmPassword else {
            alertMessage = "Passwords don't match!"
            showAlert = true
            return
        }
        
        guard agreedToTerms else {
            alertMessage = "Please agree to the terms and conditions"
            showAlert = true
            return
        }
        
        isLoading = true
        
        // Simulate sign up
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isLoading = false
            onSignUp?(email, name)
            onNavigate?("dashboard")
        }
    }
}

#Preview {
    SignUpView()
}

