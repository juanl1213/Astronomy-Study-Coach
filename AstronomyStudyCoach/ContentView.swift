//
//  ContentView.swift
//  Astronomy Study Coach
//
//  Main content view that handles navigation between all screens
//

import SwiftUI

// MARK: - Custom Transitions
extension AnyTransition {
    static var slideAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .move(edge: .leading).combined(with: .opacity)
        )
    }
    
    static var slideFadeAndScale: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing)
                .combined(with: .opacity)
                .combined(with: .modifier(
                    active: ScaleModifier(scale: 0.96),
                    identity: ScaleModifier(scale: 1.0)
                )),
            removal: .move(edge: .leading)
                .combined(with: .opacity)
                .combined(with: .modifier(
                    active: ScaleModifier(scale: 0.96),
                    identity: ScaleModifier(scale: 1.0)
                ))
        )
    }
}

// MARK: - Scale Modifier
struct ScaleModifier: ViewModifier {
    let scale: CGFloat
    
    func body(content: Content) -> some View {
        content.scaleEffect(scale)
    }
}

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            Group {
                switch appState.currentView {
                case "login":
                    LoginView(
                        onNavigate: { view in
                            appState.navigate(to: view)
                        },
                        onLogin: { email in
                            appState.login(email: email)
                        }
                    )
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                    
                case "signup":
                    SignUpView(
                        onNavigate: { view in
                            appState.navigate(to: view)
                        },
                        onSignUp: { email, name in
                            appState.signUp(email: email, name: name)
                        }
                    )
                    .transition(.slideAndFade)
                    
                case "dashboard":
                    if appState.isAuthenticated {
                        DashboardView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            }
                        )
                        .environmentObject(appState)
                        .transition(.slideFadeAndScale)
                    } else {
                        LoginView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            },
                            onLogin: { email in
                                appState.login(email: email)
                            }
                        )
                        .transition(.slideAndFade)
                    }
                    
                case "settings":
                    if appState.isAuthenticated {
                        SettingsView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            },
                            userEmail: appState.userEmail,
                            userName: appState.userName
                        )
                        .transition(.slideFadeAndScale)
                    } else {
                        LoginView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            },
                            onLogin: { email in
                                appState.login(email: email)
                            }
                        )
                        .transition(.slideAndFade)
                    }
                    
                case "quiz":
                    if appState.isAuthenticated {
                        QuizView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            }
                        )
                        .environmentObject(appState)
                        .id("quiz-view")
                        .transition(.slideFadeAndScale)
                    } else {
                        LoginView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            },
                            onLogin: { email in
                                appState.login(email: email)
                            }
                        )
                        .transition(.slideAndFade)
                    }
                    
                case "quiz-history":
                    if appState.isAuthenticated {
                        QuizHistoryView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            }
                        )
                        .environmentObject(appState)
                        .transition(.slideFadeAndScale)
                    } else {
                        LoginView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            },
                            onLogin: { email in
                                appState.login(email: email)
                            }
                        )
                        .transition(.slideAndFade)
                    }
                    
                case "study":
                    if appState.isAuthenticated {
                        StudyTopicsView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            }
                        )
                        .environmentObject(appState)
                        .transition(.slideFadeAndScale)
                    } else {
                        LoginView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            },
                            onLogin: { email in
                                appState.login(email: email)
                            }
                        )
                        .transition(.slideAndFade)
                    }
                    
             
                    
                default:
                    if appState.isAuthenticated {
                        DashboardView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            }
                        )
                        .transition(.slideFadeAndScale)
                    } else {
                        LoginView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            },
                            onLogin: { email in
                                appState.login(email: email)
                            }
                        )
                        .transition(.slideAndFade)
                    }
                }
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0), value: appState.currentView)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}


