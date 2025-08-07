import React, { useState, useEffect, useRef } from 'react';
import { ChevronDown, BarChart2, Newspaper, Info, HelpCircle, AlertTriangle, Menu, X, Sun, Moon, TrendingUp, FileText, DollarSign, Briefcase, BookOpen, Users, Award, Sliders, CheckCircle, Gauge, BarChartHorizontal, Calendar, LogIn, ArrowRight, LogOut, LayoutDashboard } from 'lucide-react';

// --- DATA ---
// Expanded data structure to support the new detailed layout.
const fundsData = [
    { 
        name: 'Praxium Active Wealth', 
        symbol: 'PAW', 
        tagline: "A Global Crypto Fund Leveraging Daily Rebalancing and Liquidity-Risk Signals Across the Top 200 Assets",
        chart: 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754439913/normal_vs_bitcoin_iv7lrw.png',
        pieChart: 'https://placehold.co/400x400/1e40af/ffffff?text=PAW+Allocations',
        price: 152.34,
        change: 2.51,
        ytdReturn: 71.51,
        risk: 'Medium',
        riskLevel: 4, // out of 5
        inceptionDate: '01-01-2020',
        managementStyle: 'Active (Proprietary Model)',
        assetClass: 'Top 200 Cryptocurrencies',
        category: 'Crypto Large-Cap Growth',
        fees: '2.0% Management Fee',
        productSummary: "This actively managed fund provides global investors with diversified exposure to the top 200 cryptocurrencies using a daily rebalanced, equal-weighted strategy. It incorporates a 14-day Amihud liquidity z-score to dynamically manage risk and enhance capital efficiency. Designed for medium-to-high risk tolerance, the fund aims to capture upside in digital assets while mitigating liquidity-driven volatility.",
        highlights: [
            "Quantitative Liquidity Risk Control: Adjusts allocations based on real-time Amihud z-scores to manage slippage and volatility.",
            "Equal-Weighted Diversification: Ensures balanced exposure across all top 200 crypto assets to avoid overconcentration.",
            "Daily Rebalancing: Actively responds to market movements, maintaining alignment with strategy and risk parameters."
        ],
        pawReturnsData: [
            { period: '1-Month', benchmark: 133.62, paw: 28.64, excess: -104.98 },
            { period: '3-Month', benchmark: 72.46, paw: 54.07, excess: -18.39 },
            { period: 'YTD', benchmark: 38.07, paw: 71.51, excess: 33.44 },
            { period: '1-Year', benchmark: 46.89, paw: 75.85, excess: 28.95 },
            { period: '3-Year', benchmark: 46.61, paw: 62.11, excess: 15.49 },
            { period: 'Since Inception', benchmark: 48.87, paw: 75.86, excess: 26.99 },
        ],
        riskMetrics: { volatility: '16.6%', sharpeRatio: '3.84', maxDrawdown: '-7.12%' },
        strategy: "The fund equally allocates capital across the top 200 cryptocurrencies and rebalances daily to maintain diversification. A 14-day Amihud illiquidity z-score is used to adjust overall portfolio exposure, reducing risk during periods of low liquidity and amplifying it when market conditions are favorable. This systematic approach ensures disciplined risk control while maintaining broad crypto exposure.",
        managementTeam: [
            { name: 'Riley Meredith, CFA', title: 'Chief Investment Officer & Portfolio Manager', bio: 'Expert in quantitative strategies and algorithmic trading with over a decade of experience in financial markets and the crypto industry.' }
        ],
    },
    { 
        name: 'Praxium Beta Sentiment', 
        symbol: 'PBS', 
        tagline: "A High-Conviction Crypto Fund Combining Liquidity Signals and Real-Time News Sentiment for Alpha Generation",
        chart: 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754439913/sentiment_vs_bitcoin_xsxumw.png',
        pieChart: 'https://placehold.co/400x400/7e22ce/ffffff?text=PBS+Allocations',
        price: 88.12,
        change: -1.47,
        ytdReturn: 56.67,
        risk: 'High',
        riskLevel: 5, // out of 5
        inceptionDate: '01-01-2020',
        managementStyle: 'Active (Sentiment-Driven)',
        assetClass: 'Top 200 Cryptocurrencies and News Sentiment',
        category: 'DeFi & Web3',
        fees: '3.0% management fee',
        productSummary: "This actively managed BETA-stage fund applies a sophisticated strategy that blends Amihud liquidity risk management with real-time crypto-specific news sentiment from CryptoCompare. Asset weights within the top 200 cryptocurrencies are dynamically adjusted based on both liquidity conditions and directional sentiment signals to capture short-term market inefficiencies. Targeted at experienced investors seeking high risk-adjusted returns, the fund is rebalanced daily and designed to deliver additional alpha through advanced signal integration.",
        highlights: [
            "Sentiment-Driven Alpha Engine: Leverages real-time crypto news sentiment to dynamically tilt asset allocations toward positive momentum opportunities.",
            "Dual-Layer Risk Management: Combines Amihud 14-day z-scores with sentiment analysis to navigate both liquidity and psychological market pressures.",
            "Cutting-Edge Quant Strategy: BETA fund applying institutional-grade models to a rapidly evolving digital asset landscape."
        ],
        pbsReturnsData: [
            { period: '1-Month', benchmark: 133.62, pbs: -5.54, excess: -139.16 },
            { period: '3-Month', benchmark: 72.46, pbs: 27.46, excess: -45.00 },
            { period: 'YTD', benchmark: 38.07, pbs: 56.67, excess: 18.60 },
            { period: '1-Year', benchmark: 46.89, pbs: 66.65, excess: 19.75 },
            { period: '3-Year', benchmark: 46.61, pbs: 61.13, excess: 14.51 },
            { period: 'Since Inception', benchmark: 48.87, pbs: 75.31, excess: 26.44 },
        ],
        riskMetrics: { volatility: '15.94%', sharpeRatio: '4.60', maxDrawdown: '-6.65%' },
        strategy: "Building on the base liquidity model, this BETA-stage fund overlays real-time crypto-specific news sentiment to influence asset weightings within the top 200 coins. Positive sentiment increases weight, while negative sentiment reduces exposure, with adjustments constrained by Amihud-based liquidity risk signals. The result is a dynamic, alpha-seeking strategy that adapts to both market mood and structural conditions.",
        managementTeam: [
            { name: 'Riley Meredith, CFA', title: 'Chief Investment Officer & Portfolio Manager', bio: 'Expert in quantitative strategies and algorithmic trading with over a decade of experience in financial markets and the crypto industry.' }
        ],
    },
];


// --- APP STRUCTURE ---

const App = () => {
    const [activePage, setActivePage] = useState('Home');
    const [isMenuOpen, setIsMenuOpen] = useState(false);
    const [theme, setTheme] = useState('dark');
    const [selectedFund, setSelectedFund] = useState(fundsData[0]);
    const [isLoggedIn, setIsLoggedIn] = useState(false);

    useEffect(() => {
        const savedTheme = localStorage.getItem('theme') || 'dark';
        setTheme(savedTheme);
    }, []);

    useEffect(() => {
        if (theme === 'dark') {
            document.documentElement.classList.add('dark');
        } else {
            document.documentElement.classList.remove('dark');
        }
        localStorage.setItem('theme', theme);
    }, [theme]);
    
    const toggleTheme = () => setTheme(prev => (prev === 'dark' ? 'light' : 'dark'));

    const navItems = [
        { name: 'Home', icon: BarChart2 },
        { name: 'Funds', icon: BarChart2 },
        { name: 'News Sentiment', icon: Newspaper },
        { name: 'About', icon: Info },
    ];
    
    const handleNavigation = (page, fundSymbol = null) => {
        if (fundSymbol) {
            const fundToSelect = fundsData.find(f => f.symbol === fundSymbol);
            if (fundToSelect) {
                setSelectedFund(fundToSelect);
            }
        }
        setActivePage(page);
    };

    const handleLogout = () => {
        setIsLoggedIn(false);
        setActivePage('Home');
    };


    const renderPage = () => {
        switch (activePage) {
            case 'Home': return <HomePage navigate={handleNavigation} />;
            case 'Funds': return <PriceFundPage selectedFund={selectedFund} setSelectedFund={setSelectedFund} />;
            case 'News Sentiment': return <NewsSentimentPage />;
            case 'About': return <AboutPage />;
            case 'Dashboard': return <DashboardPage />;
            default: return <HomePage navigate={handleNavigation} />;
        }
    };

    return (
        <div className="bg-gray-100 dark:bg-gray-900 text-gray-800 dark:text-gray-200 min-h-screen font-sans flex flex-col">
            <nav className="sticky top-0 z-50 bg-white/80 dark:bg-gray-900/80 backdrop-blur-lg shadow-md">
                <div className="container mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="flex items-center justify-between h-16">
                        <a href="#" onClick={() => setActivePage('Home')} className="flex items-center space-x-2">
                            <svg className="h-8 w-8 text-blue-500" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5-10-5-10 5z" /></svg>
                            <span className="text-2xl font-bold text-gray-900 dark:text-white">Praxium</span>
                        </a>
                        <div className="hidden md:flex md:items-center md:space-x-8">
                            {navItems.map((item) => (
                                <a key={item.name} href="#" onClick={() => setActivePage(item.name)}
                                    className={`font-medium transition-colors duration-300 ${activePage === item.name ? 'text-blue-500 dark:text-blue-400' : 'text-gray-600 dark:text-gray-300 hover:text-blue-500 dark:hover:text-blue-400'}`}>
                                    {item.name}
                                </a>
                            ))}
                        </div>
                        <div className="flex items-center">
                            <button onClick={() => setActivePage('Dashboard')} className="hidden md:flex items-center justify-center px-4 py-2 mr-2 text-sm font-medium text-gray-700 dark:text-gray-200 bg-gray-100 dark:bg-gray-800 rounded-full hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors">
                                <LayoutDashboard className="h-4 w-4 mr-2" />
                                Investor Dashboard
                            </button>
                            <button onClick={toggleTheme} className="p-2 rounded-full hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors duration-300 mr-2">
                                {theme === 'dark' ? <Sun className="h-6 w-6 text-yellow-400" /> : <Moon className="h-6 w-6 text-gray-700" />}
                            </button>
                            <div className="md:hidden">
                                <button onClick={() => setIsMenuOpen(!isMenuOpen)} className="p-2 rounded-md text-gray-700 dark:text-gray-300">
                                    {isMenuOpen ? <X className="h-6 w-6" /> : <Menu className="h-6 w-6" />}
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                {isMenuOpen && (
                    <div className="md:hidden px-2 pt-2 pb-3 space-y-1 sm:px-3">
                        {navItems.map((item) => (
                            <a key={item.name} href="#" onClick={() => { setActivePage(item.name); setIsMenuOpen(false); }}
                                className={`flex items-center px-3 py-2 rounded-md text-base font-medium ${activePage === item.name ? 'bg-blue-50 dark:bg-blue-900/50 text-blue-600 dark:text-blue-300' : 'text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800'}`}>
                                <item.icon className="mr-3 h-5 w-5" />{item.name}
                            </a>
                        ))}
                         <a href="#" onClick={() => { setActivePage('Dashboard'); setIsMenuOpen(false); }}
                                className="flex items-center px-3 py-2 rounded-md text-base font-medium text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800">
                                <LayoutDashboard className="mr-3 h-5 w-5" />Investor Dashboard
                            </a>
                    </div>
                )}
            </nav>
            <main className="flex-grow">
                <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-8">
                    {renderPage()}
                </div>
            </main>
            <Footer />
        </div>
    );
};

// --- PRICE FUND PAGE (VANGUARD STYLE REDESIGN) ---

const PriceFundPage = ({ selectedFund: initialFund, setSelectedFund: setAppSelectedFund }) => {
    const [selectedFund, setSelectedFund] = useState(initialFund || fundsData[0]);
    
    useEffect(() => {
        setSelectedFund(initialFund || fundsData[0]);
    }, [initialFund]);

    const handleFundSelect = (fund) => {
        setSelectedFund(fund);
        setAppSelectedFund(fund);
    };

    const [visibleSections, setVisibleSections] = useState({
        portfolio: false,
    });

    const toggleSection = (section) => {
        setVisibleSections(prev => ({ ...prev, [section]: !prev[section] }));
    };

    const sectionRefs = {
        overview: useRef(null),
        performance: useRef(null),
        portfolio: useRef(null),
        management: useRef(null),
    };

    const scrollToRef = (ref) => window.scrollTo({ top: ref.current.offsetTop - 80, behavior: 'smooth' });

    const TABS = [
        { name: 'Overview', ref: sectionRefs.overview, icon: Info },
        { name: 'Performance', ref: sectionRefs.performance, icon: TrendingUp },
        { name: 'Portfolio', ref: sectionRefs.portfolio, icon: Briefcase },
        { name: 'Management', ref: sectionRefs.management, icon: Users },
    ];

    return (
        <div className="space-y-8">
            {/* Fund Selector */}
            <div className="flex justify-center space-x-2 md:space-x-4 bg-gray-200 dark:bg-gray-800 p-2 rounded-full">
                {fundsData.map(fund => (
                    <button key={fund.symbol} onClick={() => handleFundSelect(fund)}
                        className={`w-full md:w-auto px-4 py-2 md:px-6 md:py-3 font-semibold rounded-full transition-all duration-300 text-sm md:text-base ${selectedFund.symbol === fund.symbol ? 'bg-blue-500 text-white shadow-lg' : 'bg-transparent text-gray-700 dark:text-gray-200 hover:bg-white/50 dark:hover:bg-gray-700/50'}`}>
                        {fund.symbol}
                    </button>
                ))}
            </div>

            {/* Fund Header */}
            <div className="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6">
                <h1 className="text-3xl md:text-4xl font-bold text-gray-900 dark:text-white">{selectedFund.name}</h1>
            </div>

            {/* Sticky Section Navigation */}
            <div className="sticky top-16 z-40 bg-gray-100/80 dark:bg-gray-900/80 backdrop-blur-md border-b border-gray-300 dark:border-gray-700 -mx-4 sm:-mx-6 lg:-mx-8 px-4 sm:px-6 lg:px-8">
                <nav className="container mx-auto flex space-x-4 sm:space-x-8 overflow-x-auto -mb-px">
                    {TABS.map((tab) => (
                        <button key={tab.name} onClick={() => scrollToRef(tab.ref)}
                            className="whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm md:text-base flex items-center transition-colors duration-300 border-transparent text-gray-500 hover:text-gray-700 dark:hover:text-gray-300 hover:border-gray-400 dark:hover:border-gray-500">
                           <tab.icon className="mr-2 h-5 w-5" /> {tab.name}
                        </button>
                    ))}
                </nav>
            </div>

            {/* Page Sections */}
            <div ref={sectionRefs.overview}><OverviewSection fund={selectedFund} /></div>
            <div ref={sectionRefs.performance}><PerformanceSection fund={selectedFund} /></div>
            <div ref={sectionRefs.portfolio}>
                <PortfolioSection 
                    isOpen={visibleSections.portfolio} 
                    onToggle={() => toggleSection('portfolio')} 
                />
            </div>
            <div ref={sectionRefs.management}><ManagementSection fund={selectedFund} /></div>
        </div>
    );
};

// --- SECTION COMPONENTS ---

const Section = ({ title, icon, children, isCollapsible = false, isOpen = true, onToggle = () => {} }) => {
    const contentRef = useRef(null);
    const HeaderTag = isCollapsible ? 'button' : 'div';

    return (
        <div className="bg-white dark:bg-gray-800 rounded-lg shadow-xl overflow-hidden flex flex-col h-full">
            <HeaderTag 
                onClick={isCollapsible ? onToggle : undefined}
                className={`w-full text-left p-6 md:p-8 ${isCollapsible ? 'cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-700/50' : ''}`}
            >
                <div className="flex justify-between items-center">
                    <div className="text-2xl font-bold text-gray-900 dark:text-white flex items-center">
                        {icon && React.createElement(icon, { className: "mr-3 h-7 w-7 text-blue-500" })}
                        {title}
                    </div>
                    {isCollapsible && (
                        <ChevronDown className={`h-6 w-6 text-gray-500 transform transition-transform duration-300 ${isOpen ? 'rotate-180' : ''}`} />
                    )}
                </div>
            </HeaderTag>
            <div
                ref={contentRef}
                style={{ maxHeight: !isCollapsible || isOpen ? `${contentRef.current?.scrollHeight}px` : '0px' }}
                className="transition-max-height duration-500 ease-in-out flex-grow"
            >
                <div className="px-6 md:px-8 pb-6 md:pb-8 pt-0 h-full">
                    {children}
                </div>
            </div>
        </div>
    );
};


const OverviewSection = ({ fund }) => (
    <Section title="Overview" icon={Info}>
        <div className="grid md:grid-cols-10 gap-8">
            <div className="md:col-span-7 space-y-4">
                <p className="text-lg font-semibold text-gray-800 dark:text-gray-200">{fund.tagline}</p>
                <p className="text-gray-600 dark:text-gray-400 leading-relaxed">{fund.productSummary}</p>
                <div>
                    <h4 className="font-semibold mb-2 text-gray-900 dark:text-white">Key Highlights:</h4>
                    <ul className="list-disc list-inside space-y-1 text-gray-600 dark:text-gray-400">
                        {fund.highlights.map((item, i) => <li key={i}>{item}</li>)}
                    </ul>
                </div>
            </div>
            <div className="md:col-span-3 bg-gray-50 dark:bg-gray-700/50 p-6 rounded-lg space-y-4">
                <h4 className="font-bold text-lg text-gray-900 dark:text-white text-left">Key Facts</h4>
                <div className="text-sm space-y-3">
                    <Fact label="YTD Return" value={`${fund.ytdReturn}%`} />
                    <Fact label="Inception Date" value={fund.inceptionDate} />
                    <Fact label="Management Style" value={fund.managementStyle} />
                    <Fact label="Asset Class" value={fund.assetClass} />
                    <Fact label="Fees" value={fund.fees} />
                    <Fact label="Risk Level">
                        <div className="flex items-center justify-end">
                            <span className="mr-2">{fund.risk}</span>
                            <div className="flex space-x-1">
                                {[...Array(5)].map((_, i) => (
                                    <div key={i} className={`h-2 w-4 rounded-full ${i < fund.riskLevel ? (fund.symbol === 'PAW' ? 'bg-orange-500' : 'bg-red-500') : 'bg-gray-300 dark:bg-gray-500'}`}></div>
                                ))}
                            </div>
                        </div>
                    </Fact>
                </div>
            </div>
        </div>
    </Section>
);

const Fact = ({label, value, children}) => (
    <div className="grid grid-cols-2 items-center">
        <span className="text-gray-500 dark:text-gray-400 text-left">{label}</span>
        <div className="text-right">
             {value ? <span className="font-semibold text-gray-900 dark:text-white">{value}</span> : children}
        </div>
    </div>
);

const PerformanceSection = ({ fund }) => (
    <Section title="Performance & Fees" icon={TrendingUp}>
        <div className="space-y-8">
            <div>
                <h3 className="text-xl font-bold mb-4 text-gray-900 dark:text-white">Performance Chart</h3>
                <img src={fund.chart} alt={`${fund.name} chart`} className="w-full h-auto rounded-lg shadow-inner" onError={(e) => { e.target.onerror = null; e.target.src='https://placehold.co/800x400/ef4444/ffffff?text=Image+Failed+to+Load'; }}/>
            </div>
            <div>
                <h3 className="text-xl font-bold mb-4 text-gray-900 dark:text-white">Average Annual Returns</h3>
                <p className="text-gray-600 dark:text-gray-400 mb-4 text-sm">Hypothetical performance data as of last month-end. Past performance is not indicative of future results.</p>
                <div className="overflow-x-auto">
                    {fund.symbol === 'PAW' ? (
                         <table className="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead className="bg-gray-50 dark:bg-gray-700">
                                <tr>
                                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Period</th>
                                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Bitcoin Benchmark</th>
                                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">PAW</th>
                                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Excess Return</th>
                                </tr>
                            </thead>
                            <tbody className="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
                                {fund.pawReturnsData.map((row) => (
                                    <tr key={row.period} className="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                                        <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">{row.period}</td>
                                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400 text-right">{row.benchmark.toFixed(2)}%</td>
                                        <td className="px-6 py-4 whitespace-nowrap text-sm text-blue-500 dark:text-blue-400 font-semibold text-right">{row.paw.toFixed(2)}%</td>
                                        <td className={`px-6 py-4 whitespace-nowrap text-sm font-semibold text-right ${row.excess >= 0 ? 'text-green-500' : 'text-red-500'}`}>
                                            {row.excess >= 0 ? '+' : ''}{row.excess.toFixed(2)}%
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    ) : fund.symbol === 'PBS' ? (
                        <table className="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead className="bg-gray-50 dark:bg-gray-700">
                                <tr>
                                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Period</th>
                                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Bitcoin Benchmark</th>
                                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">PBS</th>
                                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Excess Return</th>
                                </tr>
                            </thead>
                            <tbody className="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
                                {fund.pbsReturnsData.map((row) => (
                                    <tr key={row.period} className="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                                        <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">{row.period}</td>
                                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400 text-right">{row.benchmark.toFixed(2)}%</td>
                                        <td className="px-6 py-4 whitespace-nowrap text-sm text-blue-500 dark:text-blue-400 font-semibold text-right">{row.pbs.toFixed(2)}%</td>
                                        <td className={`px-6 py-4 whitespace-nowrap text-sm font-semibold text-right ${row.excess >= 0 ? 'text-green-500' : 'text-red-500'}`}>
                                            {row.excess >= 0 ? '+' : ''}{row.excess.toFixed(2)}%
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    ) : null}
                </div>
            </div>
            <div>
                 <h3 className="text-xl font-bold mb-4 text-gray-900 dark:text-white">Risk Metrics</h3>
                 <div className="grid grid-cols-2 md:grid-cols-3 gap-4 text-center">
                    <MetricCard label="Annualized Volatility" value={fund.riskMetrics.volatility} />
                    <MetricCard label="Sharpe Ratio" value={fund.riskMetrics.sharpeRatio} />
                    <MetricCard label="Max Drawdown" value={fund.riskMetrics.maxDrawdown} />
                 </div>
            </div>
        </div>
    </Section>
);

const MetricCard = ({label, value}) => (
    <div className="bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg">
        <p className="text-sm text-gray-500 dark:text-gray-400">{label}</p>
        <p className="text-2xl font-bold text-gray-900 dark:text-white">{value}</p>
    </div>
);

const PortfolioSection = ({ fund, isOpen, onToggle }) => {
    const portfolioData = [
        { symbol: 'TAO', meanRet: 97.61, std: 3190.51, skew: 32.77, kurt: 1073.99, missing: 0.1 },
        { symbol: 'PI', meanRet: 66.56, std: 2987.94, skew: 45.08, kurt: 2031.96, missing: 0.0 },
        { symbol: 'MWC', meanRet: 31.76, std: 1263.06, skew: 43.77, kurt: 1933.43, missing: 0.1 },
        { symbol: 'TFUEL', meanRet: 7.78, std: 349.76, skew: 45.06, kurt: 2031.15, missing: 0.0 },
        { symbol: 'BEAM', meanRet: 7.53, std: 176.22, skew: 24.96, kurt: 627.71, missing: 0.2 },
        { symbol: 'PEPE', meanRet: 6.37, std: 138.58, skew: 28.37, kurt: 813.62, missing: 0.1 },
        { symbol: 'USELESS', meanRet: 4.17, std: 12.39, skew: 0.58, kurt: 0.31, missing: 2.9 },
        { symbol: 'PNUT', meanRet: 2.44, std: 27.78, skew: 7.58, kurt: 68.51, missing: 0.4 },
        { symbol: 'FARTCOIN', meanRet: 2.41, std: 15.49, skew: 0.84, kurt: 1.09, missing: 0.4 },
        { symbol: 'TURBO', meanRet: 2.13, std: 27.09, skew: 11.32, kurt: 177.12, missing: 0.1 },
        { symbol: 'MOG', meanRet: 1.62, std: 14.82, skew: 2.47, kurt: 15.07, missing: 0.1 },
        { symbol: 'VIRTUAL', meanRet: 1.6, std: 12.2, skew: 1.73, kurt: 6.45, missing: 0.2 },
        { symbol: 'POPCAT', meanRet: 1.51, std: 15.51, skew: 1.72, kurt: 9.41, missing: 0.2 },
        { symbol: 'TOSHI', meanRet: 1.33, std: 15.27, skew: 2.73, kurt: 13.4, missing: 0.1 },
        { symbol: 'CHEEMS', meanRet: 1.2, std: 9.75, skew: 1.8, kurt: 12.15, missing: 0.3 },
        { symbol: 'DEEP', meanRet: 1.06, std: 11.1, skew: 2.98, kurt: 22.5, missing: 0.4 },
        { symbol: 'IP', meanRet: 1.02, std: 12.75, skew: 3.26, kurt: 28.03, missing: 0.6 },
        { symbol: 'TON', meanRet: 0.97, std: 33.25, skew: 35.89, kurt: 1334.75, missing: 0.1 },
        { symbol: 'AERO', meanRet: 0.97, std: 10.03, skew: 3.58, kurt: 25.37, missing: 0.2 },
        { symbol: 'SAROS', meanRet: 0.95, std: 9.48, skew: 2.54, kurt: 15.83, missing: 0.2 },
        { symbol: 'BONK', meanRet: 0.85, std: 11.14, skew: 5.22, kurt: 66.07, missing: 0.1 },
        { symbol: 'MEW', meanRet: 0.76, std: 11.36, skew: 3.12, kurt: 19.7, missing: 0.2 },
        { symbol: 'WIF', meanRet: 0.75, std: 10.74, skew: 1.3, kurt: 4.98, missing: 0.2 },
        { symbol: 'APT', meanRet: 0.73, std: 20.65, skew: 28.47, kurt: 871.4, missing: 0.1 },
        { symbol: 'HYPE', meanRet: 0.68, std: 6.46, skew: 0.45, kurt: 1.04, missing: 0.4 },
        { symbol: 'USDS', meanRet: 0.67, std: 27.94, skew: 42.16, kurt: 1843.8, missing: 0.0 },
        { symbol: 'MORPHO', meanRet: 0.66, std: 8.88, skew: 1.26, kurt: 5.13, missing: 0.4 },
        { symbol: 'SPX', meanRet: 0.62, std: 8.92, skew: 2.62, kurt: 20.26, missing: 0.0 },
        { symbol: 'GALA', meanRet: 0.59, std: 11.37, skew: 6.04, kurt: 70.02, missing: 0.1 },
        { symbol: 'SYRUP', meanRet: 0.58, std: 7.33, skew: 0.8, kurt: 1.12, missing: 0.4 },
        { symbol: 'RNDR', meanRet: 0.56, std: 8.89, skew: 1.61, kurt: 10.72, missing: 0.0 },
        { symbol: 'MSQ', meanRet: 0.56, std: 10.65, skew: 1.64, kurt: 21.54, missing: 0.1 },
        { symbol: 'DOGE', meanRet: 0.55, std: 10.88, skew: 22.37, kurt: 763.83, missing: 0.0 },
        { symbol: 'PENGU', meanRet: 0.53, std: 9.32, skew: 0.9, kurt: 2.25, missing: 0.5 },
        { symbol: 'QNT', meanRet: 0.5, std: 8.48, skew: 5.65, kurt: 96.99, missing: 0.0 },
        { symbol: 'SNEK', meanRet: 0.5, std: 8.77, skew: 0.96, kurt: 11.05, missing: 0.1 },
        { symbol: 'KAS', meanRet: 0.49, std: 5.95, skew: 0.83, kurt: 2.31, missing: 0.1 },
        { symbol: 'ZBCN', meanRet: 0.49, std: 8.13, skew: 0.8, kurt: 2.59, missing: 0.2 },
        { symbol: 'SOL', meanRet: 0.49, std: 6.59, skew: 0.55, kurt: 5.51, missing: 0.1 },
        { symbol: 'LPT', meanRet: 0.46, std: 9.52, skew: 5.03, kurt: 61.3, missing: 0.0 },
        { symbol: 'ONDO', meanRet: 0.46, std: 6.21, skew: 1.14, kurt: 3.95, missing: 0.2 },
        { symbol: 'TEL', meanRet: 0.45, std: 8.17, skew: 1.44, kurt: 7.9, missing: 0.0 },
        { symbol: 'AXS', meanRet: 0.42, std: 7.45, skew: 2.14, kurt: 14.25, missing: 0.1 },
        { symbol: 'FLOKI', meanRet: 0.42, std: 9.04, skew: 3.16, kurt: 22.38, missing: 0.1 },
        { symbol: 'KMNO', meanRet: 0.42, std: 8.5, skew: 2.17, kurt: 13.48, missing: 0.2 },
        { symbol: 'RSR', meanRet: 0.41, std: 8.39, skew: 3.64, kurt: 60.97, missing: 0.0 },
        { symbol: 'FET', meanRet: 0.41, std: 7.31, skew: 0.36, kurt: 5.76, missing: 0.0 },
        { symbol: 'BRETT', meanRet: 0.41, std: 8.81, skew: 0.95, kurt: 2.47, missing: 0.2 },
        { symbol: 'XDC', meanRet: 0.41, std: 6.07, skew: 3.84, kurt: 34.46, missing: 0.1 },
        { symbol: 'DEXE', meanRet: 0.41, std: 9.08, skew: 8.36, kurt: 145.95, missing: 0.1 },
        { symbol: 'INJ', meanRet: 0.4, std: 7.02, skew: 0.79, kurt: 4.83, missing: 0.1 },
        { symbol: 'TWT', meanRet: 0.39, std: 7.99, skew: 5.64, kurt: 90.87, missing: 0.1 },
        { symbol: 'GRASS', meanRet: 0.39, std: 8.66, skew: 1.63, kurt: 10.27, missing: 0.3 },
        { symbol: 'CFX', meanRet: 0.39, std: 9.03, skew: 4.76, kurt: 56.31, missing: 0.1 },
        { symbol: 'AVAX', meanRet: 0.37, std: 7.38, skew: 2.05, kurt: 22.62, missing: 0.1 },
        { symbol: 'HBAR', meanRet: 0.37, std: 6.96, skew: 3.96, kurt: 44.18, missing: 0.0 },
        { symbol: 'BDX', meanRet: 0.37, std: 10.72, skew: 17.01, kurt: 501.73, missing: 0.0 },
        { symbol: 'JUP', meanRet: 0.36, std: 8.84, skew: 7.03, kurt: 113.4, missing: 0.2 },
        { symbol: 'BGB', meanRet: 0.36, std: 3.61, skew: 1.59, kurt: 8.77, missing: 0.1 },
        { symbol: 'FXS', meanRet: 0.36, std: 10.49, skew: 7.91, kurt: 173.73, missing: 0.1 },
        { symbol: 'STX', meanRet: 0.34, std: 7.22, skew: 3.25, kurt: 46.21, missing: 0.0 },
        { symbol: 'MATIC', meanRet: 0.34, std: 6.6, skew: 1.55, kurt: 14.17, missing: 0.0 },
        { symbol: 'SAND', meanRet: 0.34, std: 7.52, skew: 2.96, kurt: 29.8, missing: 0.1 },
        { symbol: 'MANA', meanRet: 0.34, std: 7.31, skew: 5.6, kurt: 110.78, missing: 0.0 },
        { symbol: 'AIOZ', meanRet: 0.34, std: 10.25, skew: 5.07, kurt: 70.54, missing: 0.1 },
        { symbol: 'AR', meanRet: 0.34, std: 7.46, skew: 1.55, kurt: 9.07, missing: 0.1 },
        { symbol: 'OM', meanRet: 0.33, std: 8.14, skew: 0.99, kurt: 16.59, missing: 0.1 },
        { symbol: 'JASMY', meanRet: 0.33, std: 8.82, skew: 3.74, kurt: 31.87, missing: 0.1 },
        { symbol: 'RUNE', meanRet: 0.33, std: 7.39, skew: 0.3, kurt: 3.69, missing: 0.1 },
        { symbol: 'GNO', meanRet: 0.33, std: 7.3, skew: 11.47, kurt: 322.71, missing: 0.0 },
        { symbol: 'AB', meanRet: 0.33, std: 11.39, skew: 3.82, kurt: 27.91, missing: 1.1 },
        { symbol: 'FIL', meanRet: 0.32, std: 10.35, skew: 15.99, kurt: 494.35, missing: 0.0 },
        { symbol: 'PENDLE', meanRet: 0.31, std: 7.37, skew: 1.58, kurt: 12.4, missing: 0.1 },
        { symbol: 'KAIA', meanRet: 0.31, std: 6.71, skew: 3.09, kurt: 24.2, missing: 0.4 },
        { symbol: 'THETA', meanRet: 0.3, std: 6.15, skew: 0.04, kurt: 4.9, missing: 0.0 },
        { symbol: 'DOG', meanRet: 0.3, std: 8.76, skew: 0.94, kurt: 1.84, missing: 0.2 },
        { symbol: 'WBT', meanRet: 0.3, std: 3.92, skew: 9.94, kurt: 163.39, missing: 0.1 },
        { symbol: 'CHZ', meanRet: 0.3, std: 6.74, skew: 2.69, kurt: 36.96, missing: 0.0 },
        { symbol: 'ADA', meanRet: 0.3, std: 5.44, skew: 1.54, kurt: 20.13, missing: 0.0 },
        { symbol: 'BNB', meanRet: 0.3, std: 4.6, skew: 1.72, kurt: 37.18, missing: 0.0 },
        { symbol: 'CAKE', meanRet: 0.3, std: 6.78, skew: 0.13, kurt: 18.46, missing: 0.1 },
        { symbol: 'CORE', meanRet: 0.29, std: 7.83, skew: 4.03, kurt: 38.19, missing: 0.1 },
        { symbol: 'GAS', meanRet: 0.29, std: 6.97, skew: 3.46, kurt: 49.12, missing: 0.0 },
        { symbol: 'GT', meanRet: 0.29, std: 4.78, skew: 5.85, kurt: 130.0, missing: 0.0 },
        { symbol: 'XRP', meanRet: 0.29, std: 5.66, skew: 2.3, kurt: 27.51, missing: 0.0 },
        { symbol: 'BIGTIME', meanRet: 0.28, std: 9.55, skew: 4.14, kurt: 40.64, missing: 0.2 },
        { symbol: 'FTN', meanRet: 0.28, std: 1.56, skew: 2.64, kurt: 15.45, missing: 0.1 },
        { symbol: 'SUI', meanRet: 0.28, std: 5.74, skew: 1.05, kurt: 4.1, missing: 0.1 },
        { symbol: 'ARKM', meanRet: 0.28, std: 6.95, skew: 1.18, kurt: 6.2, missing: 0.1 },
        { symbol: 'SUPER', meanRet: 0.27, std: 8.19, skew: 1.85, kurt: 20.12, missing: 0.1 },
        { symbol: 'HNT', meanRet: 0.27, std: 6.9, skew: 1.42, kurt: 9.66, missing: 0.1 },
        { symbol: 'AAVE', meanRet: 0.27, std: 5.99, skew: 0.43, kurt: 3.31, missing: 0.1 },
        { symbol: 'LINK', meanRet: 0.27, std: 5.65, skew: 0.05, kurt: 5.93, missing: 0.0 },
        { symbol: 'NEAR', meanRet: 0.26, std: 6.61, skew: 0.67, kurt: 4.67, missing: 0.1 },
        { symbol: 'JST', meanRet: 0.26, std: 5.84, skew: 1.98, kurt: 18.6, missing: 0.1 },
        { symbol: 'TRX', meanRet: 0.26, std: 4.74, skew: 4.0, kurt: 89.77, missing: 0.0 },
        { symbol: 'UNI', meanRet: 0.26, std: 6.54, skew: 2.99, kurt: 35.96, missing: 0.1 },
        { symbol: 'ETH', meanRet: 0.26, std: 4.39, skew: -0.33, kurt: 10.19, missing: 0.0 },
        { symbol: 'XLM', meanRet: 0.26, std: 5.63, skew: 3.07, kurt: 35.6, missing: 0.0 },
        { symbol: 'NEXO', meanRet: 0.25, std: 4.88, skew: -0.18, kurt: 10.62, missing: 0.0 },
        { symbol: 'VET', meanRet: 0.25, std: 5.85, skew: 0.21, kurt: 6.67, missing: 0.0 },
        { symbol: 'CTC', meanRet: 0.25, std: 7.71, skew: 9.95, kurt: 240.28, missing: 0.1 },
        { symbol: 'KCS', meanRet: 0.25, std: 4.96, skew: 1.76, kurt: 20.08, missing: 0.0 },
        { symbol: 'GRT', meanRet: 0.25, std: 7.62, skew: 3.66, kurt: 44.91, missing: 0.1 },
        { symbol: 'MKR', meanRet: 0.24, std: 5.79, skew: 1.41, kurt: 19.03, missing: 0.0 },
        { symbol: 'ETC', meanRet: 0.23, std: 5.53, skew: 1.18, kurt: 12.02, missing: 0.0 },
        { symbol: 'CVX', meanRet: 0.23, std: 7.5, skew: 1.16, kurt: 6.82, missing: 0.1 },
        { symbol: 'SKY', meanRet: 0.23, std: 5.05, skew: 0.66, kurt: 2.0, missing: 0.3 },
        { symbol: 'SHIB', meanRet: 0.22, std: 6.15, skew: 3.31, kurt: 28.67, missing: 0.1 },
        { symbol: 'FTT', meanRet: 0.22, std: 7.18, skew: 2.31, kurt: 40.37, missing: 0.0 },
        { symbol: 'RAY', meanRet: 0.21, std: 7.51, skew: 1.7, kurt: 13.56, missing: 0.1 },
        { symbol: 'MOCA', meanRet: 0.21, std: 8.41, skew: 3.63, kurt: 31.06, missing: 0.3 },
        { symbol: 'CRO', meanRet: 0.2, std: 5.23, skew: 1.8, kurt: 26.02, missing: 0.0 },
        { symbol: 'TIA', meanRet: 0.2, std: 6.92, skew: 1.02, kurt: 2.99, missing: 0.2 },
        { symbol: 'XMR', meanRet: 0.2, std: 4.41, skew: -0.5, kurt: 16.7, missing: 0.0 },
        { symbol: 'QTUM', meanRet: 0.19, std: 5.88, skew: 0.58, kurt: 11.66, missing: 0.0 },
        { symbol: 'CRV', meanRet: 0.19, std: 7.73, skew: 1.1, kurt: 11.66, missing: 0.1 },
        { symbol: 'SEI', meanRet: 0.19, std: 6.89, skew: -0.34, kurt: 12.82, missing: 0.1 },
        { symbol: 'BTC', meanRet: 0.19, std: 3.33, skew: -0.69, kurt: 14.41, missing: 0.0 },
        { symbol: 'LDO', meanRet: 0.19, std: 7.75, skew: 1.3, kurt: 9.8, missing: 0.1 },
        { symbol: 'JTO', meanRet: 0.18, std: 6.72, skew: 1.23, kurt: 6.02, missing: 0.2 },
        { symbol: 'RVN', meanRet: 0.18, std: 6.41, skew: 1.83, kurt: 19.82, missing: 0.0 },
        { symbol: 'ALGO', meanRet: 0.18, std: 5.85, skew: 0.43, kurt: 8.53, missing: 0.0 },
        { symbol: 'BCH', meanRet: 0.18, std: 5.32, skew: 1.3, kurt: 20.47, missing: 0.0 },
        { symbol: 'LUNC', meanRet: 0.18, std: 6.48, skew: 2.55, kurt: 19.48, missing: 0.1 },
        { symbol: 'FLUID', meanRet: 0.17, std: 7.86, skew: -0.28, kurt: 24.28, missing: 0.1 },
        { symbol: 'ATOM', meanRet: 0.17, std: 5.77, skew: 0.18, kurt: 6.23, missing: 0.0 },
        { symbol: 'MIOTA', meanRet: 0.17, std: 5.61, skew: 0.43, kurt: 9.55, missing: 0.0 },
        { symbol: 'ENS', meanRet: 0.17, std: 6.57, skew: 1.88, kurt: 15.89, missing: 0.1 },
        { symbol: 'COMP', meanRet: 0.16, std: 6.64, skew: 3.5, kurt: 56.35, missing: 0.1 },
        { symbol: 'LEO', meanRet: 0.16, std: 2.98, skew: 4.19, kurt: 79.43, missing: 0.0 },
        { symbol: 'SFP', meanRet: 0.16, std: 6.98, skew: 11.58, kurt: 278.79, missing: 0.1 },
        { symbol: 'LTC', meanRet: 0.16, std: 4.74, skew: -0.2, kurt: 7.08, missing: 0.0 },
        { symbol: 'XCN', meanRet: 0.16, std: 7.83, skew: 4.73, kurt: 49.75, missing: 0.1 },
        { symbol: 'WLD', meanRet: 0.16, std: 7.35, skew: 1.63, kurt: 9.11, missing: 0.1 },
        { symbol: 'AMP', meanRet: 0.15, std: 6.59, skew: 3.16, kurt: 30.37, missing: 0.1 },
        { symbol: 'MANTLE', meanRet: 0.15, std: 4.16, skew: 1.48, kurt: 8.69, missing: 0.1 },
        { symbol: 'EGLD', meanRet: 0.15, std: 5.58, skew: 0.63, kurt: 6.52, missing: 0.1 },
        { symbol: 'WEMIX', meanRet: 0.14, std: 6.2, skew: 1.67, kurt: 13.71, missing: 0.1 },
        { symbol: 'DCR', meanRet: 0.14, std: 5.42, skew: 2.85, kurt: 56.02, missing: 0.0 },
        { symbol: 'NEO', meanRet: 0.14, std: 5.5, skew: 0.35, kurt: 8.92, missing: 0.0 },
        { symbol: 'OP', meanRet: 0.14, std: 6.55, skew: 0.91, kurt: 5.59, missing: 0.1 },
        { symbol: 'KAVA', meanRet: 0.14, std: 6.03, skew: -0.27, kurt: 7.19, missing: 0.0 },
        { symbol: 'XTZ', meanRet: 0.13, std: 5.6, skew: 0.65, kurt: 11.17, missing: 0.0 },
        { symbol: 'BSV', meanRet: 0.12, std: 6.52, skew: 6.21, kurt: 123.78, missing: 0.0 },
        { symbol: 'DASH', meanRet: 0.11, std: 5.39, skew: 0.99, kurt: 15.35, missing: 0.0 },
        { symbol: 'EOS', meanRet: 0.11, std: 6.23, skew: 4.03, kurt: 94.86, missing: 0.0 },
        { symbol: 'AXL', meanRet: 0.09, std: 5.61, skew: 1.75, kurt: 11.15, missing: 0.1 },
        { symbol: 'AKT', meanRet: 0.09, std: 6.4, skew: 0.83, kurt: 4.8, missing: 0.1 },
        { symbol: 'ETHFI', meanRet: 0.08, std: 7.76, skew: 1.53, kurt: 7.23, missing: 0.2 },
        { symbol: 'RENDER', meanRet: 0.08, std: 5.1, skew: 0.42, kurt: 1.42, missing: 0.2 },
        { symbol: 'HTX', meanRet: 0.06, std: 4.69, skew: 6.38, kurt: 111.04, missing: 0.2 },
        { symbol: 'PAXG', meanRet: 0.05, std: 1.06, skew: -0.35, kurt: 11.26, missing: 0.0 },
        { symbol: 'FLR', meanRet: 0.05, std: 4.9, skew: 2.07, kurt: 12.3, missing: 0.1 },
        { symbol: '1INCH', meanRet: 0.05, std: 5.9, skew: 0.39, kurt: 6.95, missing: 0.1 },
        { symbol: 'PYTH', meanRet: 0.04, std: 6.03, skew: 0.99, kurt: 5.46, missing: 0.2 },
        { symbol: 'XAUT', meanRet: 0.04, std: 0.87, skew: 0.08, kurt: 5.16, missing: 0.0 },
        { symbol: 'IMX', meanRet: 0.03, std: 6.39, skew: 0.84, kurt: 4.67, missing: 0.1 },
        { symbol: 'RYO', meanRet: 0.03, std: 5.36, skew: -0.66, kurt: 4.78, missing: 0.3 },
        { symbol: 'SUN', meanRet: 0.03, std: 6.72, skew: -0.91, kurt: 47.33, missing: 0.1 },
        { symbol: 'QUBIC', meanRet: 0.02, std: 7.01, skew: 1.32, kurt: 5.27, missing: 0.2 },
        { symbol: 'USDJ', meanRet: 0.01, std: 1.27, skew: 2.11, kurt: 55.39, missing: 0.1 },
        { symbol: 'MINA', meanRet: 0.01, std: 6.75, skew: -0.1, kurt: 36.94, missing: 0.1 },
        { symbol: 'USDY', meanRet: 0.01, std: 0.4, skew: 0.14, kurt: 30.67, missing: 0.2 },
        { symbol: 'BUIDL', meanRet: -0.0, std: 0.02, skew: -0.11, kurt: 0.74, missing: 3.8 },
        { symbol: 'USDG', meanRet: 0.0, std: 0.01, skew: 0.13, kurt: -0.2, missing: 1.1 },
        { symbol: 'USDE', meanRet: 0.0, std: 0.38, skew: 1.52, kurt: 99.68, missing: 0.2 },
        { symbol: 'USDD', meanRet: 0.0, std: 0.27, skew: 0.06, kurt: 22.81, missing: 0.1 },
        { symbol: 'USDC', meanRet: -0.0, std: 0.11, skew: -3.55, kurt: 435.38, missing: 0.0 },
        { symbol: 'USD1', meanRet: 0.0, std: 0.04, skew: 0.12, kurt: 3.86, missing: 1.0 },
        { symbol: 'USDTB', meanRet: -0.0, std: 0.02, skew: -0.38, kurt: -0.66, missing: 5.9 },
        { symbol: 'USDT', meanRet: -0.0, std: 0.05, skew: 1.69, kurt: 35.0, missing: 0.0 },
        { symbol: 'PYUSD', meanRet: 0.0, std: 0.23, skew: 1.44, kurt: 41.54, missing: 0.1 },
        { symbol: 'DAI', meanRet: -0.0, std: 0.3, skew: 0.18, kurt: 35.73, missing: 0.0 },
        { symbol: 'GOHM', meanRet: 0.0, std: 2.75, skew: -23.04, kurt: 729.57, missing: 0.1 },
        { symbol: 'FDUSD', meanRet: 0.0, std: 0.12, skew: -0.39, kurt: 26.26, missing: 0.1 },
        { symbol: 'TUSD', meanRet: -0.0, std: 0.16, skew: 7.85, kurt: 238.39, missing: 0.0 },
        { symbol: 'ENA', meanRet: -0.01, std: 8.59, skew: -0.25, kurt: 9.51, missing: 0.2 },
        { symbol: 'FLOW', meanRet: -0.01, std: 5.66, skew: 1.05, kurt: 8.87, missing: 0.1 },
        { symbol: 'BTT', meanRet: -0.01, std: 4.58, skew: 5.32, kurt: 73.03, missing: 0.1 },
        { symbol: 'APE', meanRet: -0.02, std: 6.2, skew: 1.62, kurt: 20.84, missing: 0.1 },
        { symbol: 'DYDX', meanRet: -0.02, std: 6.2, skew: 0.56, kurt: 5.09, missing: 0.1 },
        { symbol: 'NFT', meanRet: -0.02, std: 4.99, skew: 2.89, kurt: 41.73, missing: 0.1 },
        { symbol: 'XEC', meanRet: -0.05, std: 5.27, skew: 2.94, kurt: 38.68, missing: 0.1 },
        { symbol: 'ICP', meanRet: -0.06, std: 5.6, skew: 0.87, kurt: 6.55, missing: 0.1 },
        { symbol: 'POL', meanRet: -0.06, std: 4.46, skew: 0.17, kurt: 1.36, missing: 0.2 },
        { symbol: 'ATH', meanRet: -0.07, std: 5.02, skew: 0.14, kurt: 0.49, missing: 0.2 },
        { symbol: 'ARB', meanRet: -0.09, std: 5.8, skew: -3.51, kurt: 61.52, missing: 0.1 },
        { symbol: 'VENOM', meanRet: -0.12, std: 4.89, skew: 2.32, kurt: 19.01, missing: 0.2 },
        { symbol: 'S', meanRet: -0.14, std: 6.94, skew: 0.66, kurt: 1.75, missing: 0.5 },
        { symbol: 'RONIN', meanRet: -0.15, std: 6.13, skew: -1.93, kurt: 21.15, missing: 0.1 },
        { symbol: 'SAFE', meanRet: -0.17, std: 5.87, skew: 1.63, kurt: 9.53, missing: 0.1 },
        { symbol: 'TRUMP', meanRet: -0.19, std: 9.08, skew: 2.64, kurt: 16.23, missing: 0.5 },
        { symbol: 'WMTX', meanRet: -0.26, std: 5.18, skew: 0.24, kurt: 1.94, missing: 0.4 },
        { symbol: 'A', meanRet: -0.27, std: 3.51, skew: -0.75, kurt: 1.62, missing: 1.7 },
        { symbol: 'SOLV', meanRet: -0.35, std: 7.2, skew: 0.21, kurt: 3.1, missing: 0.5 },
        { symbol: 'STRK', meanRet: -0.36, std: 5.71, skew: 0.31, kurt: 1.54, missing: 0.2 },
        { symbol: 'EIGEN', meanRet: -0.43, std: 8.83, skew: -1.19, kurt: 13.69, missing: 0.3 },
        { symbol: 'MOVE', meanRet: -0.45, std: 7.58, skew: 1.74, kurt: 9.18, missing: 0.4 },
        { symbol: 'BERA', meanRet: -0.56, std: 7.22, skew: 0.38, kurt: 3.12, missing: 0.6 },
    ];
    return (
        <Section title="Portfolio Composition" icon={Briefcase} isCollapsible={true} isOpen={isOpen} onToggle={onToggle}>
            <div className="overflow-x-auto">
                <table className="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                    <thead className="bg-gray-50 dark:bg-gray-700">
                        <tr>
                            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Symbol</th>
                            <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">MEAN RETURN (%)</th>
                            <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Std(%)</th>
                            <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Skew</th>
                            <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Kurt</th>
                            <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Missing(%)</th>
                        </tr>
                    </thead>
                    <tbody className="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
                        {portfolioData.map((item) => (
                            <tr key={item.symbol} className="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                                <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">{item.symbol}</td>
                                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400 text-right">{item.meanRet.toFixed(2)}</td>
                                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400 text-right">{item.std.toFixed(2)}</td>
                                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400 text-right">{item.skew.toFixed(2)}</td>
                                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400 text-right">{item.kurt.toFixed(2)}</td>
                                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400 text-right">{item.missing.toFixed(1)}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </Section>
    );
};

const ManagementSection = ({ fund }) => (
    <Section title="Strategy & Management" icon={Users}>
        <div>
            <h3 className="text-xl font-bold mb-2 text-gray-900 dark:text-white">Methodology</h3>
            <p className="text-gray-600 dark:text-gray-400 leading-relaxed">{fund.strategy}</p>
        </div>
        <div className="mt-8">
            <h3 className="text-xl font-bold mb-4 text-gray-900 dark:text-white">Management Team</h3>
            <div className="space-y-6">
                {fund.managementTeam.map(m => (
                    <div key={m.name} className="flex items-start space-x-4">
                        <div className="flex-shrink-0 h-12 w-12 rounded-full bg-gray-200 dark:bg-gray-700 flex items-center justify-center">
                            <Users className="h-6 w-6 text-gray-500" />
                        </div>
                        <div>
                            <p className="font-bold text-lg text-gray-900 dark:text-white">{m.name}</p>
                            <p className="font-semibold text-blue-500 dark:text-blue-400">{m.title}</p>
                            <p className="text-sm text-gray-600 dark:text-gray-400 mt-1">{m.bio}</p>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    </Section>
);

// --- NEWS / SENTIMENT PAGE ---

const FilterButtons = ({ filters, activeFilter, onFilterChange }) => (
    <div className="flex flex-wrap gap-2 mb-4">
        {filters.map(filter => (
            <button
                key={filter}
                onClick={() => onFilterChange(filter)}
                className={`px-3 py-1 text-sm font-semibold rounded-full transition-colors duration-200 ${
                    activeFilter === filter
                        ? 'bg-blue-500 text-white shadow'
                        : 'bg-gray-200 dark:bg-gray-700 text-gray-700 dark:text-gray-200 hover:bg-gray-300 dark:hover:bg-gray-600'
                }`}
            >
                {filter}
            </button>
        ))}
    </div>
);

const NewsSentimentPage = () => {
    const [visibleSections, setVisibleSections] = useState({
        fearGreed: true, dailySentiment: true, trendingCategories: true,
        histogram: true, heatmap: true, quality: true,
    });
    const [areAllCollapsed, setAreAllCollapsed] = useState(false);

    const [activeFilters, setActiveFilters] = useState({
        fearGreed: 'Total', dailySentiment: 'Total',
        histogram: 'Total', heatmap: 'Total',
    });

    const toggleAllSections = () => {
        const newState = !areAllCollapsed;
        setAreAllCollapsed(newState);
        const newVisibleState = {};
        Object.keys(visibleSections).forEach(key => {
            newVisibleState[key] = !newState;
        });
        setVisibleSections(newVisibleState);
    };

    const toggleSection = (section) => {
        setVisibleSections(prev => ({ ...prev, [section]: !prev[section] }));
    };

    const handleFilterChange = (section, filter) => {
        setActiveFilters(prev => ({ ...prev, [section]: filter }));
    };
    
    const filterOptions = ['Total', 'BTC', 'ETH', 'Meme', 'Institutional'];
    
    const fearGreedImageUrls = {
        'Total': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398263/fear_greed_gauge_ypkerp.png',
        'BTC': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398262/fear_greed_gauge_BTC_kokmrb.png',
        'ETH': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398262/fear_greed_gauge_ETH_gu79gz.png',
        'Meme': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398262/fear_greed_gauge_Meme_wl7r8p.png',
        'Institutional': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398262/fear_greed_gauge_Institutional_dd591o.png'
    };

    const dailySentimentImageUrls = {
        'Total': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398514/daily_avg_sentiment_r3bagw.png',
        'BTC': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398514/daily_avg_sentiment_BTC_qoqc8b.png',
        'ETH': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398514/daily_avg_sentiment_ETH_fgwvom.png',
        'Meme': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398514/daily_avg_sentiment_Meme_dqdi7v.png',
        'Institutional': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398514/daily_avg_sentiment_is_institutional_udqnks.png'
    };

    const histogramImageUrls = {
        'Total': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754399044/hist_final_aovwb6.png',
        'BTC': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398851/hist_final_BTC_yc3qmu.png',
        'ETH': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398852/hist_final_ETH_ihgpep.png',
        'Meme': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398852/hist_final_Meme_o8vkaf.png',
        'Institutional': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754398852/hist_final_Institutional_xcm8j4.png'
    };
    
    const heatmapImageUrls = {
        'Total': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754399333/monthly_avg_heatmap_hywy39.png',
        'BTC': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754399331/monthly_avg_heatmap_BTC_w8k3qj.png',
        'ETH': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754399331/monthly_avg_heatmap_ETH_fqshs2.png',
        'Meme': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754399332/monthly_avg_heatmap_Meme_ljkrsz.png',
        'Institutional': 'https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754399410/monthly_avg_heatmap_Institutional_yyblvm.png'
    };

    const trendingCategoriesData = [
        { coin: 'Mixed', count: 60133 }, { coin: 'BTC', count: 7710 },
        { coin: 'Tech', count: 2747 }, { coin: 'LTC', count: 2622 },
        { coin: 'ETH', count: 1514 }, { coin: 'XRP', count: 1253 },
        { coin: 'Regulatory', count: 1112 }, { coin: 'Market', count: 991 },
        { coin: 'TOKE', count: 976 }, { coin: 'NFT', count: 724 },
        { coin: 'BNB', count: 562 }, { coin: 'Institutional', count: 436 },
        { coin: 'OM', count: 430 }, { coin: 'Meme', count: 428 },
        { coin: 'Defi', count: 414 }, { coin: 'SOL', count: 406 },
        { coin: 'REN', count: 398 }, { coin: 'ADA', count: 349 },
        { coin: 'FOR', count: 219 }, { coin: 'Macro', count: 165 },
    ];
    
    const qualityAssuranceData = [
        { metric: 'Total Articles Processed', count: 155958 },
        { metric: 'Articles After Filtering', count: 106525 },
        { metric: 'Articles Excluded', count: 49433 },
        { metric: 'Exclusion Rate (%)', count: 31.7 },
        { metric: 'Sponsored Content', count: 101867 },
        { metric: 'Scam Indicators', count: 2735 },
        { metric: 'Spam Content', count: 45292 },
        { metric: 'Excessive Formatting', count: 49 },
        { metric: 'Repetitive Content', count: 42 },
        { metric: 'Too Short', count: 84 },
        { metric: 'All Caps', count: 53 },
        { metric: 'Average Quality Score', count: 0.901 },
        { metric: 'Min Quality Score', count: 0.52 },
        { metric: 'Max Quality Score', count: 1.0 },
    ];

    return (
        <div className="space-y-8">
            <div className="text-center">
                <h1 className="text-4xl md:text-5xl font-extrabold text-gray-900 dark:text-white">News & Sentiment Analysis</h1>
                <p className="mt-4 max-w-2xl mx-auto text-lg text-gray-600 dark:text-gray-400">
                    A data-driven look into the crypto market's pulse, providing insights from news trends and social sentiment.
                </p>
            </div>

            <div className="flex justify-end mb-4">
                <button
                    onClick={toggleAllSections}
                    className="px-4 py-2 text-sm font-semibold rounded-full transition-colors duration-200 bg-blue-500 text-white hover:bg-blue-600 dark:bg-blue-600 dark:hover:bg-blue-700"
                >
                    {areAllCollapsed ? 'Expand All' : 'Collapse All'}
                </button>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                <Section title="Fear & Greed Index" icon={Gauge} isCollapsible={true} isOpen={visibleSections.fearGreed} onToggle={() => toggleSection('fearGreed')}>
                    <p className="text-gray-600 dark:text-gray-400 mb-4 text-sm">A visual representation of the current market sentiment, from Extreme Fear to Extreme Greed.</p>
                    <FilterButtons filters={filterOptions} activeFilter={activeFilters.fearGreed} onFilterChange={(filter) => handleFilterChange('fearGreed', filter)} />
                    <img src={fearGreedImageUrls[activeFilters.fearGreed]} alt="Fear and Greed Gauge" className="w-full h-auto rounded-lg shadow-inner"/>
                </Section>
                <Section title="Daily Weighted Sentiment" icon={TrendingUp} isCollapsible={true} isOpen={visibleSections.dailySentiment} onToggle={() => toggleSection('dailySentiment')}>
                    <p className="text-gray-600 dark:text-gray-400 mb-4 text-sm">Tracks the weighted average sentiment score across all news sources over the last 30 days.</p>
                    <FilterButtons filters={filterOptions} activeFilter={activeFilters.dailySentiment} onFilterChange={(filter) => handleFilterChange('dailySentiment', filter)} />
                    <img src={dailySentimentImageUrls[activeFilters.dailySentiment]} alt="Daily Weighted Average Sentiment Chart" className="w-full h-auto rounded-lg shadow-inner"/>
                </Section>
            </div>

            <Section title="Top 20 Trending News Categories" icon={Newspaper} isCollapsible={true} isOpen={visibleSections.trendingCategories} onToggle={() => toggleSection('trendingCategories')}>
                 <p className="text-gray-600 dark:text-gray-400 mb-4 text-sm">A snapshot of the most discussed topics in crypto news over the past 24 hours.</p>
                 <div className="overflow-x-auto">
                    <table className="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                        <thead className="bg-gray-50 dark:bg-gray-700">
                            <tr>
                                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Category</th>
                                <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Article Count</th>
                            </tr>
                        </thead>
                        <tbody className="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
                            {trendingCategoriesData.map((item) => (
                                <tr key={item.coin} className="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                                    <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">{item.coin}</td>
                                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400 text-right">{item.count.toLocaleString()}</td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                 </div>
            </Section>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                <Section title="Sentiment Histogram" icon={BarChartHorizontal} isCollapsible={true} isOpen={visibleSections.histogram} onToggle={() => toggleSection('histogram')}>
                    <p className="text-gray-600 dark:text-gray-400 mb-4 text-sm">Distribution of positive, neutral, and negative sentiment scores from today's news articles.</p>
                    <FilterButtons filters={filterOptions} activeFilter={activeFilters.histogram} onFilterChange={(filter) => handleFilterChange('histogram', filter)} />
                    <img src={histogramImageUrls[activeFilters.histogram]} alt="Sentiment Histogram" className="w-full h-auto rounded-lg shadow-inner"/>
                </Section>
                <Section title="Monthly Sentiment Heatmap" icon={Calendar} isCollapsible={true} isOpen={visibleSections.heatmap} onToggle={() => toggleSection('heatmap')}>
                    <p className="text-gray-600 dark:text-gray-400 mb-4 text-sm">A heatmap showing the average sentiment for each day of the past month, highlighting trends.</p>
                    <FilterButtons filters={filterOptions} activeFilter={activeFilters.heatmap} onFilterChange={(filter) => handleFilterChange('heatmap', filter)} />
                    <img src={heatmapImageUrls[activeFilters.heatmap]} alt="Monthly Sentiment Heatmap" className="w-full h-auto rounded-lg shadow-inner"/>
                </Section>
            </div>

            <Section title="Quality Filtering Assurance" icon={CheckCircle} isCollapsible={true} isOpen={visibleSections.quality} onToggle={() => toggleSection('quality')}>
                <p className="text-gray-600 dark:text-gray-400 mb-4 text-sm">Our data pipeline ensures high-quality, relevant sentiment analysis by systematically cleaning and filtering raw news data.</p>
                <div className="overflow-x-auto">
                    <table className="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                        <thead className="bg-gray-50 dark:bg-gray-700">
                            <tr>
                                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Metric</th>
                                <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Count / Value</th>
                            </tr>
                        </thead>
                        <tbody className="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
                            {qualityAssuranceData.map((item) => (
                                <tr key={item.metric} className="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                                    <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">{item.metric}</td>
                                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400 text-right">{item.count.toLocaleString()}</td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                 </div>
            </Section>
        </div>
    );
};


// --- OTHER PAGES ---

const HomePage = ({ navigate }) => (
    <div className="space-y-12">
        <section className="text-center bg-gradient-to-r from-blue-500 to-purple-600 dark:from-blue-800 dark:to-purple-900 rounded-lg p-8 md:p-16 shadow-lg">
            <h1 className="text-4xl md:text-6xl font-extrabold text-white mb-4">Welcome to Praxium</h1>
            <p className="text-lg md:text-xl text-blue-100 dark:text-purple-200 max-w-3xl mx-auto">
                Your gateway to institutional-grade crypto investment strategies. Discover curated portfolios, explore real-time market sentiment, and unlock the future of digital asset management.
            </p>
        </section>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            <NavCard
                title="Praxium Active Wealth (PAW)"
                description="A diversified, equal-weighted strategy across the top 200 crypto assets, managed with a proprietary liquidity-risk model."
                onClick={() => navigate('Funds', 'PAW')}
            />
            <NavCard
                title="Praxium Beta Sentiment (PBS)"
                description="A high-conviction BETA fund that integrates real-time news sentiment with liquidity signals to capture alpha."
                onClick={() => navigate('Funds', 'PBS')}
            />
        </div>
        <NavCard
            title="News & Sentiment Analysis"
            description="Explore our data-driven insights into the crypto market's pulse, from fear and greed to trending topics."
            onClick={() => navigate('News Sentiment')}
        />
        <NavCard
            title="About Praxium"
            description="Learn more about our mission, our team, and our approach to quantitative crypto investing."
            onClick={() => navigate('About')}
        />
    </div>
);

const NavCard = ({ title, description, onClick }) => (
    <div className="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6 flex flex-col justify-between">
        <div>
            <h3 className="text-xl font-bold text-gray-900 dark:text-white mb-2">{title}</h3>
            <p className="text-gray-600 dark:text-gray-400">{description}</p>
        </div>
        <button onClick={onClick} className="mt-4 self-start flex items-center font-semibold text-blue-500 dark:text-blue-400 hover:text-blue-600 dark:hover:text-blue-300">
            Learn More <ArrowRight className="ml-2 h-4 w-4" />
        </button>
    </div>
);


const AboutPage = () => (
    <Section title="About Praxium">
        <div className="space-y-8 text-lg text-gray-600 dark:text-gray-300 leading-relaxed">
            <div>
                <h2 className="text-2xl font-bold text-gray-900 dark:text-white mb-3">Our Mission</h2>
                <p>
                    To bridge the gap between traditional quantitative finance and the dynamic world of digital assets. We aim to provide investors with sophisticated, data-driven strategies that navigate the complexities of the crypto market with clarity and precision.
                </p>
            </div>
            <div>
                <h2 className="text-2xl font-bold text-gray-900 dark:text-white mb-3">Our Philosophy</h2>
                <p>
                    We believe that successful crypto investing is not about hype, but about rigorous analysis. Our approach is built on three pillars: <strong>Data-Driven Decisions</strong>, <strong>Systematic Risk Management</strong>, and <strong>Continuous Innovation</strong>. We filter out market noise to focus on quantifiable signals, from liquidity metrics to real-time sentiment, ensuring our strategies are adaptive and robust.
                </p>
            </div>
            <div>
                <h2 className="text-2xl font-bold text-gray-900 dark:text-white mb-3">Our Technology</h2>
                <p>
                    At the heart of Praxium is a proprietary engine that processes vast amounts of market and alternative data. Our models, developed through years of research, identify patterns in liquidity, sentiment, and market structure. This allows us to rebalance portfolios daily, systematically capturing opportunities while managing the inherent volatility of the crypto asset class.
                </p>
            </div>
             <div>
                <h2 className="text-2xl font-bold text-gray-900 dark:text-white mb-3">Our Team</h2>
                <p>
                    Praxium is led by a team of experts with deep roots in both quantitative finance and blockchain technology. Our founder, Riley Meredith, CFA, brings over a decade of experience in building and managing algorithmic trading strategies. Our team is dedicated to pioneering the next generation of digital asset management.
                </p>
            </div>
        </div>
    </Section>
);

const ResourcesPage = () => {
    const [visibleSections, setVisibleSections] = useState({});

    const toggleSection = (section) => {
        setVisibleSections(prev => ({ ...prev, [section]: !prev[section] }));
    };

    const toggleAll = () => {
        const allVisible = Object.values(visibleSections).every(v => v);
        const newVisibleState = {};
        Object.keys(resourceSections).forEach((_, index) => {
            newVisibleState[`section-${index}`] = !allVisible;
        });
        setVisibleSections(newVisibleState);
    };

    const resourceSections = [
        { title: "Data Sources & Methodology", icon: BarChart2, content: "Placeholder for tables and charts on data sources." },
        { title: "Risk Metrics Glossary", icon: HelpCircle, content: "Placeholder for definitions of Sharpe Ratio, Max Drawdown, etc." },
        { title: "Liquidity Analysis Deep Dive", icon: Sliders, content: "Placeholder for detailed charts and tables on the Amihud score." },
        { title: "Sentiment Analysis Deep Dive", icon: Newspaper, content: "Placeholder for details on the sentiment engine." },
        { title: "Backtesting Results", icon: TrendingUp, content: "Placeholder for detailed backtesting charts and tables." },
        { title: "Fee Structure Details", icon: DollarSign, content: "A breakdown of how fees are calculated will be presented here." },
    ];
    
    useEffect(() => {
        const initialState = {};
        resourceSections.forEach((_, index) => {
            initialState[`section-${index}`] = false;
        });
        setVisibleSections(initialState);
    }, []);


    return (
        <div className="space-y-8">
             <div className="text-center">
                <h1 className="text-4xl md:text-5xl font-extrabold text-gray-900 dark:text-white">Resources & Appendix</h1>
                <p className="mt-4 max-w-2xl mx-auto text-lg text-gray-600 dark:text-gray-400">
                   A collection of detailed information, glossaries, and deep dives into our methodologies.
                </p>
            </div>
             <div className="flex justify-end mb-4">
                <button
                    onClick={toggleAll}
                    className="px-4 py-2 text-sm font-semibold rounded-full transition-colors duration-200 bg-blue-500 text-white hover:bg-blue-600 dark:bg-blue-600 dark:hover:bg-blue-700"
                >
                    {Object.values(visibleSections).every(v => v) ? 'Collapse All' : 'Expand All'}
                </button>
            </div>
            <div className="space-y-4">
            {resourceSections.map((section, index) => (
                <Section 
                    key={index}
                    title={section.title} 
                    icon={section.icon} 
                    isCollapsible={true} 
                    isOpen={visibleSections[`section-${index}`]} 
                    onToggle={() => toggleSection(`section-${index}`)}
                >
                    <p className="text-gray-500 dark:text-gray-400">{section.content}</p>
                </Section>
            ))}
            </div>
        </div>
    );
};


const FAQPage = () => (<ResourcesPage />);
const LoginPage = ({ setIsLoggedIn, setActivePage }) => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');

    const handleLogin = (e) => {
        e.preventDefault();
        if (email === 'investor@praxium.com' && password === 'password123') {
            setIsLoggedIn(true);
            setActivePage('Dashboard');
            setError('');
        } else {
            setError('Invalid username or password.');
        }
    };

    return (
        <Section title="Login">
            <div className="max-w-md mx-auto">
                 <div className="bg-blue-100 dark:bg-blue-900/30 border border-blue-300 dark:border-blue-700 text-blue-800 dark:text-blue-200 px-4 py-3 rounded-lg relative mb-6" role="alert">
                    <strong className="font-bold">Demo Credentials:</strong>
                    <ul className="mt-2 list-disc list-inside text-sm">
                        <li>Username: <span className="font-mono">investor@praxium.com</span></li>
                        <li>Password: <span className="font-mono">password123</span></li>
                    </ul>
                </div>

                <form onSubmit={handleLogin} className="space-y-4">
                    <div>
                        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">Email Address</label>
                        <input 
                            type="email" 
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            className="mt-1 block w-full px-3 py-2 bg-white dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500" 
                            placeholder="you@example.com" />
                    </div>
                    <div>
                        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">Password</label>
                        <input 
                            type="password" 
                            placeholder="••••••••" 
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            className="mt-1 block w-full px-3 py-2 bg-white dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500" />
                    </div>
                    {error && <p className="text-sm text-red-500">{error}</p>}
                    <button type="submit" className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        Sign In
                    </button>
                </form>
            </div>
        </Section>
    );
};

const DashboardPage = () => {
    const portfolioData = [
        { symbol: 'DOGE', meanRet: 0.55, std: 10.88, skew: 22.37, kurt: 763.83, missing: 0.0 },
        { symbol: 'SOL', meanRet: 0.49, std: 6.59, skew: 0.55, kurt: 5.51, missing: 0.1 },
        { symbol: 'CHZ', meanRet: 0.30, std: 6.74, skew: 2.69, kurt: 36.96, missing: 0.0 },
        { symbol: 'BNB', meanRet: 0.30, std: 4.60, skew: 1.72, kurt: 37.18, missing: 0.0 },
        { symbol: 'XRP', meanRet: 0.29, std: 5.66, skew: 2.30, kurt: 27.51, missing: 0.0 },
        { symbol: 'ETH', meanRet: 0.26, std: 4.39, skew: -0.33, kurt: 10.19, missing: 0.0 },
        { symbol: 'BTC', meanRet: 0.19, std: 3.33, skew: -0.69, kurt: 14.41, missing: 0.0 },
        { symbol: 'KAVA', meanRet: 0.14, std: 6.03, skew: -0.27, kurt: 7.19, missing: 0.0 },
        { symbol: '1INCH', meanRet: 0.05, std: 5.90, skew: 0.39, kurt: 6.95, missing: 0.1 },
        { symbol: 'TRUMP', meanRet: -0.19, std: 9.08, skew: 2.64, kurt: 16.23, missing: 0.5 },
    ];

    return (
        <div className="space-y-8">
            <div className="text-center">
                <h1 className="text-4xl md:text-5xl font-extrabold text-gray-900 dark:text-white">Investor Dashboard</h1>
                <p className="mt-4 max-w-2xl mx-auto text-lg text-gray-600 dark:text-gray-400">
                    Welcome back. Here's a snapshot of your hypothetical portfolio.
                </p>
            </div>

            <Section title="Manage Your Investment" icon={DollarSign}>
                <div className="flex flex-col md:flex-row gap-4">
                     <button className="w-full flex justify-center items-center py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                        Add Funds
                    </button>
                     <button className="w-full flex justify-center items-center py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                        Withdraw Position
                    </button>
                </div>
            </Section>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 items-stretch">
                <div className="lg:col-span-2">
                    <Section title="Portfolio Performance" icon={TrendingUp}>
                         <p className="text-gray-600 dark:text-gray-400 mb-4 text-sm">Your portfolio's value over the last 90 days.</p>
                         <img src="https://res.cloudinary.com/dhk9hlkn2/image/upload/v1754561291/ew_returns_candles_zocofr.png" alt="Portfolio Performance" className="w-full h-auto rounded-lg shadow-inner"/>
                    </Section>
                </div>
                <div>
                     <Section title="Portfolio Overview" icon={Briefcase}>
                        <p className="text-gray-600 dark:text-gray-400 mb-4 text-sm">Your current asset allocation.</p>
                         <div className="overflow-x-auto">
                            <table className="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                                <thead className="bg-gray-50 dark:bg-gray-700">
                                    <tr>
                                        <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Symbol</th>
                                        <th className="px-4 py-2 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Mean Return (%)</th>
                                    </tr>
                                </thead>
                                <tbody className="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
                                    {portfolioData.map((item) => (
                                        <tr key={item.symbol} className="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                                            <td className="px-4 py-2 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">{item.symbol}</td>
                                            <td className="px-4 py-2 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400 text-right">{item.meanRet.toFixed(2)}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </Section>
                </div>
            </div>
        </div>
    );
};


// --- FOOTER ---

const Footer = () => (
    <footer className="bg-white dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700 mt-auto">
        <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <div className="text-center text-xs text-gray-500 dark:text-gray-400 space-y-4">
                <div className="font-bold text-sm text-gray-700 dark:text-gray-300">Important Disclaimer</div>
                <p className="max-w-4xl mx-auto">
                    This website, Praxium, is a fictional concept and a software demonstration project. It is not a real financial services company, investment platform, or advisory service. All information presented on this site, including but not limited to fund names, performance charts, and return calculations, is entirely hypothetical and for illustrative purposes only.
                </p>
                <p className="max-w-4xl mx-auto">
                    <strong>This is not financial advice.</strong> The content on this website should not be construed as a recommendation, solicitation, or offer to buy or sell any securities or digital assets. Investing in cryptocurrencies is highly speculative and involves a significant risk of loss.
                </p>
                <div className="pt-4 border-t border-gray-200 dark:border-gray-700 mt-4">
                     &copy; {new Date().getFullYear()} Praxium. All Rights Reserved.
                </div>
            </div>
        </div>
    </footer>
);

export default App;
