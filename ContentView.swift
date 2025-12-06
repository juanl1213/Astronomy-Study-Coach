//
//  ContentView.swift
//  Astronomy Study Coach
//
//  Main content view that handles navigation between all screens
//

import SwiftUI

// MARK: - Custom Transitions (Following Apple HIG)
extension AnyTransition {
    // Apple HIG: Simple opacity fade for content changes (0.2-0.3s duration)
    static var slideAndFade: AnyTransition {
        .opacity
    }
    
    // Apple HIG: Subtle fade with minimal horizontal movement for navigation
    static var slideFadeAndScale: AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .move(edge: .trailing)),
            removal: .opacity.combined(with: .move(edge: .leading))
        )
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
                    .transition(.slideAndFade)
                    
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
                    
                // Quiz routes (quiz-{quizId})
                case let view where view.hasPrefix("quiz-") && view != "quiz-history":
                    if appState.isAuthenticated {
                        let quizId = String(view.dropFirst(5)) // Remove "quiz-" prefix
                        QuizView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            },
                            initialQuizId: quizId
                        )
                        .environmentObject(appState)
                        .id("quiz-view-\(quizId)")
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
                
                // Lesson views
                case let view where view.hasPrefix("lesson-"):
                    if appState.isAuthenticated {
                        let lessonId = String(view.dropFirst(7)) // Remove "lesson-" prefix
                        LessonView(
                            lessonId: lessonId,
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
                    
                case "achievements":
                    if appState.isAuthenticated {
                        AchievementsView(
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
                    
                case "progress":
                    if appState.isAuthenticated {
                        ProgressView(
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
                    
                case "resources":
                    if appState.isAuthenticated {
                        ResourcesView(
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
                    
                case "flashcards":
                    if appState.isAuthenticated {
                        FlashcardsView(
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
                    
                case "glossary":
                    if appState.isAuthenticated {
                        GlossaryView(
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
                    
                case "ai-assistant":
                    if appState.isAuthenticated {
                        AIStudyAssistantView(
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
                    
                case "constellations":
                    if appState.isAuthenticated {
                        ConstellationsView(
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
                    
                case "search":
                    if appState.isAuthenticated {
                        SearchView(
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
            // Apple HIG: 0.25-0.3s duration for responsive, natural transitions
            .animation(.easeInOut(duration: 0.3), value: appState.currentView)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}


