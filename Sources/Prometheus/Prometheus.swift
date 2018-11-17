public class Prometheus {
    /// Singleton instance
    ///
    /// Use this to create Metric trackers and retrieve your data,
    /// so you don't have to keep track of an instance.
    public static let shared = Prometheus()
    
    /// Metrics tracked by this Prometheus instance
    internal var metrics: [Metric] = []
    
    // MARK: - Counter
    
    /// Creates a counter with the given values
    ///
    /// - Parameters:
    ///     - type: Type the counter will count
    ///     - name: Name of the counter
    ///     - helpText: Help text for the counter. Usually a short description
    ///     - initialValue: An initial value to set the counter to, defaults to 0
    ///     - labelType: Type of labels this counter can use. Can be left out to default to no labels
    ///
    /// - Returns: Counter instance
    public func createCounter<T: Numeric, U: MetricLabels>(
        forType type: T.Type,
        named name: String,
        helpText: String? = nil,
        initialValue: T = 0,
        withLabelType labelType: U.Type) -> Counter<T, U>
    {
        let counter = Counter<T, U>(name, helpText, initialValue)
        self.metrics.append(counter)
        return counter
    }
    
    /// Creates a counter with the given values
    ///
    /// - Parameters:
    ///     - type: Type the counter will count
    ///     - name: Name of the counter
    ///     - helpText: Help text for the counter. Usually a short description
    ///     - initialValue: An initial value to set the counter to, defaults to 0
    ///
    /// - Returns: Counter instance
    public func createCounter<T: Numeric>(
        forType: T.Type,
        named name: String,
        helpText: String? = nil,
        initialValue: T = 0) -> Counter<T, EmptyCodable>
    {
        return self.createCounter(forType: T.self, named: name, helpText: helpText, initialValue: initialValue, withLabelType: EmptyCodable.self)
    }
    
    // MARK: - Gauge
    
    /// Creates a gauge with the given values
    ///
    /// - Parameters:
    ///     - type: Type the gauge will hold
    ///     - name: Name of the gauge
    ///     - helpText: Help text for the gauge. Usually a short description
    ///     - initialValue: An initial value to set the gauge to, defaults to 0
    ///     - labelType: Type of labels this gauge can use. Can be left out to default to no labels
    ///
    /// - Returns: Gauge instance
    public func createGauge<T: Numeric, U: MetricLabels>(
        forType type: T.Type,
        named name: String,
        helpText: String? = nil,
        initialValue: T = 0,
        withLabelType labelType: U.Type) -> Gauge<T, U>
    {
        let gauge = Gauge<T, U>(name, helpText, initialValue)
        self.metrics.append(gauge)
        return gauge
    }
    
    /// Creates a gauge with the given values
    ///
    /// - Parameters:
    ///     - type: Type the gauge will count
    ///     - name: Name of the gauge
    ///     - helpText: Help text for the gauge. Usually a short description
    ///     - initialValue: An initial value to set the gauge to, defaults to 0
    ///
    /// - Returns: Gauge instance
    public func createGauge<T: Numeric>(
        forType: T.Type,
        named name: String,
        helpText: String? = nil,
        initialValue: T = 0) -> Gauge<T, EmptyCodable>
    {
        return self.createGauge(forType: T.self, named: name, helpText: helpText, initialValue: initialValue, withLabelType: EmptyCodable.self)
    }
    
    /// Creates prometheus formatted metrics
    ///
    /// - Returns: Newline seperated string with metrics for all Metric Trackers of this Prometheus instance
    public func getMetrics() -> String {
        return metrics.map { $0.getMetric() }.joined(separator: "\n\n")
    }
}
