//
//  LoginView.swift
//  Astronomy Study Coach
//
//  Login screen matching the React application design
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var showForgotPassword: Bool = false
    
    var onNavigate: ((String) -> Void)?
    var onLogin: ((String) -> Void)?
    
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
                        Text("Welcome Back")
                            .font(.appTitle)
                            .foregroundStyle(LinearGradient.textGradient)
                        
                        Text("Continue your journey through the cosmos")
                            .font(.appBody)
                            .foregroundColor(.mutedForeground)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, Spacing.xl)
                    
                    // Login Card
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        // Card Header
                        VStack(alignment: .leading, spacing: Spacing.xs) {
                            Text("Sign In")
                                .font(.appHeading)
                                .foregroundColor(.foreground)
                            
                            Text("Enter your credentials to access your astronomy learning dashboard")
                                .font(.appCaption)
                                .foregroundColor(.mutedForeground)
                        }
                        .padding(.bottom, Spacing.sm)
                        
                        // Form
                        VStack(spacing: Spacing.md) {
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
                                HStack {
                                    Text("Password")
                                        .font(.appBody)
                                        .foregroundColor(.foreground)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        showForgotPassword = true
                                    }) {
                                        Text("Forgot password?")
                                            .font(.appSmall)
                                            .foregroundColor(.indigo400)
                                    }
                                }
                                
                                HStack {
                                    Image(systemName: "lock")
                                        .foregroundColor(.mutedForeground)
                                        .frame(width: 20)
                                    
                                    SecureField("••••••••", text: $password)
                                        .textContentType(.password)
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
                            
                            // Sign In Button
                            Button(action: {
                                handleLogin()
                            }) {
                                HStack {
                                    Text(isLoading ? "Signing in..." : "Sign In")
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
                            .disabled(isLoading || email.isEmpty || password.isEmpty)
                            .opacity((isLoading || email.isEmpty || password.isEmpty) ? 0.6 : 1.0)
                            .padding(.top, Spacing.sm)
                        }
                        
                        // Separator
                        HStack {
                            Rectangle()
                                .fill(Color.border)
                                .frame(height: 1)
                        }
                        .padding(.vertical, Spacing.md)
                        
                        // Demo Account Button
                        Button(action: {
                            email = "astronomer@space.edu"
                            password = "password"
                            handleDemoLogin()
                        }) {
                            Text("Try Demo Account")
                                .font(.appBody)
                                .foregroundColor(.foreground)
                                .frame(maxWidth: .infinity)
                                .padding(Spacing.md)
                                .background(Color.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: CornerRadius.md)
                                        .stroke(Color.border, lineWidth: 1)
                                )
                        }
                        
                        // Sign Up Link
                        HStack {
                            Text("Don't have an account?")
                                .font(.appSmall)
                                .foregroundColor(.mutedForeground)
                            
                            Button(action: {
                                onNavigate?("signup")
                            }) {
                                Text("Sign up for free")
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
                    
                    // Terms Text
                    Text("By signing in, you agree to our Terms of Service and Privacy Policy")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, Spacing.lg)
                }
                .padding(Spacing.md)
                .frame(maxWidth: 500)
            }
        }
        .alert("Forgot Password", isPresented: $showForgotPassword) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Password reset functionality coming soon!")
        }
    }
    
    private func handleLogin() {
        isLoading = true
        
        // Simulate login
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isLoading = false
            onLogin?(email)
            onNavigate?("dashboard")
        }
    }
    
    private func handleDemoLogin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            onLogin?("astronomer@space.edu")
            onNavigate?("dashboard")
        }
    }
}

#Preview {
    LoginView()
}

