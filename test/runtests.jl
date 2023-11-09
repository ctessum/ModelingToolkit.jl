using SafeTestsets, Test

@safetestset "Linear Algebra Test" include("linalg.jl")
@safetestset "AbstractSystem Test" include("abstractsystem.jl")
@safetestset "Variable Scope Tests" include("variable_scope.jl")
@safetestset "Symbolic Parameters Test" include("symbolic_parameters.jl")
@safetestset "Parsing Test" include("variable_parsing.jl")
@safetestset "Simplify Test" include("simplify.jl")
@safetestset "Direct Usage Test" include("direct.jl")
@safetestset "System Linearity Test" include("linearity.jl")
@safetestset "Linearization Tests" include("linearize.jl")
@safetestset "Input Output Test" include("input_output_handling.jl")
@safetestset "Clock Test" include("clock.jl")
@safetestset "DiscreteSystem Test" include("discretesystem.jl")
@safetestset "ODESystem Test" include("odesystem.jl")
#@safetestset "Dynamic Quantities Test" begin
#    using DynamicQuantities
#    include("units.jl")
#end
@safetestset "Unitful Quantities Test" begin
    using Unitful
    include("units.jl")
end
@safetestset "LabelledArrays Test" include("labelledarrays.jl")
@safetestset "Mass Matrix Test" include("mass_matrix.jl")
@safetestset "SteadyStateSystem Test" include("steadystatesystems.jl")
@safetestset "SDESystem Test" include("sdesystem.jl")
@safetestset "NonlinearSystem Test" include("nonlinearsystem.jl")
@safetestset "PDE Construction Test" include("pde.jl")
@safetestset "JumpSystem Test" include("jumpsystem.jl")
@safetestset "Constraints Test" include("constraints.jl")
@safetestset "Reduction Test" include("reduction.jl")
@safetestset "Split Parameters Test" include("split_parameters.jl")
@safetestset "ODAEProblem Test" include("odaeproblem.jl")
@safetestset "Components Test" include("components.jl")
@safetestset "Model Parsing Test" include("model_parsing.jl")
@safetestset "print_tree" include("print_tree.jl")
@safetestset "Error Handling" include("error_handling.jl")
@safetestset "StructuralTransformations" include("structural_transformation/runtests.jl")
@safetestset "State Selection Test" include("state_selection.jl")
@safetestset "Symbolic Event Test" include("symbolic_events.jl")
@safetestset "Stream Connect Test" include("stream_connectors.jl")
@safetestset "Domain Connect Test" include("domain_connectors.jl")
@safetestset "Lowering Integration Test" include("lowering_solving.jl")
@safetestset "Test Big System Usage" include("bigsystem.jl")
@safetestset "Dependency Graph Test" include("dep_graphs.jl")
@safetestset "Function Registration Test" include("function_registration.jl")
@safetestset "Precompiled Modules Test" include("precompile_test.jl")
@testset "Distributed Test" begin
    include("distributed.jl")
end
@safetestset "Variable Utils Test" include("variable_utils.jl")
@safetestset "Variable Metadata Test" include("test_variable_metadata.jl")
@safetestset "DAE Jacobians Test" include("dae_jacobian.jl")
@safetestset "Jacobian Sparsity" include("jacobiansparsity.jl")
println("Last test requires gcc available in the path!")
@safetestset "C Compilation Test" include("ccompile.jl")
@testset "Serialization" begin
    include("serialization.jl")
end
@safetestset "Modelingtoolkitize Test" include("modelingtoolkitize.jl")
@safetestset "OptimizationSystem Test" include("optimizationsystem.jl")
@safetestset "FuncAffect Test" include("funcaffect.jl")
@safetestset "Constants Test" include("constants.jl")
# Reference tests go Last
if VERSION >= v"1.9"
    @safetestset "Latexify recipes Test" include("latexify.jl")
end
@safetestset "BifurcationKit Extension Test" include("extensions/bifurcationkit.jl")
