{ pkgs, opencode, ... }:
{
  programs.opencode = {
    enable = true;
    package = opencode.packages.${pkgs.system}.default;
    enableMcpIntegration = true;
    rules = ''
      Always use Context7 MCP when I need library/API documentation, code generation, setup or configuration steps without me having to explicitly ask.
      Always use Cargo Clippy in place of Cargo Check

      <CONFIGURATION_MANAGEMENT>
        ALWAYS use .env or config files as single source of truth and ensure .env files are gitignored
        Provide .env.example with all required variables
        Validate environment variables on startup
        Group related configuration together
      </CONFIGURATION_MANAGEMENT>

      <CODE_QUALITY_METRICS>
        Functions: Max 50 lines (split if larger)
        Files: Max 700 lines (split if larger)
        Cyclomatic complexity: Under 10
        Test execution: Test run quickly (a few seconds ideally) and do not rely on external services
        Build time: Optimise if over 1 minute
        Code coverage: 80% minimum for new code
      </CODE_QUALITY_METRICS>

      <SOFTWARE_TESTING_PRACTICES> <TESTING_WORKFLOW> 1. Write failing test for bugs (test-first) 2. Fix the bug 3. Verify test passes 4. Check no other tests broken 5. Only then declare fixed </TESTING_WORKFLOW>

      <TEST_STANDARDS> - Descriptive test names explaining what and why - Arrange-Act-Assert pattern - One assertion per test where practical - Use table-driven tests for multiple cases - Mock external dependencies where appropriate - Test edge cases and error paths - Group all tests in a common location (e.g. test/ or tests/) </TEST_STANDARDS> </SOFTWARE_TESTING_PRACTICES>

      <VERIFICATION_CHECKLIST> Before declaring any task complete:

          Linting passes with no warnings or errors
          Code builds without warnings
          All tests pass (new and existing)
          No debug statements or console.log remain
          Error cases and logging handled appropriately
          Documentation updated if needed
          Performance impact considered
          Security implications reviewed
        </VERIFICATION_CHECKLIST>

        <WRITING_STYLE note="IMPORTANT"> <AVOID_AI_CLICHES> - You must NEVER use overused AI phrases especially those that are not quantifiable or measurable such as: comprehensive , robust , smoking gun, best-in-class , feature-rich , production-ready , enterprise-grade - DO NOT write with smart quotes or em dashes - Avoid excessive bullet points with bolded headers - No unnecessary summary paragraphs and other fluff - DO NOT engage in sycophantic or obsequious communication - DO NOT write content that could be interpreted as marketing or hype and do not use overly enthusiastic or self-congratulatory language </AVOID_AI_CLICHES>

        <WRITE_NATURALLY> - Write as if you're a knowledgeable engineer explaining to a colleague, do not write as someone selling a product - Be direct, concise and specific, not vague or grandiose - Use active voice and concrete examples - If a sentence adds no value, delete it! </WRITE_NATURALLY>

        <FINAL_CHECK> When writing documentation does it sound like a real person explaining something they know, or Wikipedia crossed with a press release? Natural writing is messier, more varied, more specific than AI defaults. </FINAL_CHECK> </WRITING_STYLE>

        <SPELLING_AND_LOCALISATION note="IMPORTANT"> CRITICAL: YOU MUST ALWAYS USE  BRITISH ENGLISH SPELLING FOR ALL RESPONSES, DOCUMENTATION, COMMENTS, DEFINITIONS AND FUNCTION NAMES. DO NOT USE AMERICAN SPELLING. <BRITISH_ENGLISH_RULES> - ALWAYS ensure consistent use of BRITISH English in all your interactions, BRITISH ENGLISH SPELLING MUST BE USED IN ALL WRITING! - Look out for Z's when there should be S's - Using American spelling makes users sad, confused, frustrated and disappointed in your performance <KEY_PATTERNS> You must follow these BRITISH English spelling and usage rules during all your task, e.g: 1. Use -our instead of -or (colour, favour, behaviour) 2. Use -ise/-yse instead of -ize/-yze (organise, analyse, optimise) 3. Use -re instead of -er (centre, metre, theatre) 4. Use -ogue instead of -og (catalogue, dialogue, analogue) 5. Use -ae/-oe instead of -e (anaemia, oesophagus) 6. Use -ll- instead of -l- (travelled, cancelled, modelling) 7. Use -t instead of -ed for certain past tense (learnt, dreamt, spelt) 8. Use -ence instead of -ense for nouns (defence, licence, offence) 9. Use British vocabulary (mum, aeroplane, autumn, lift, boot) </KEY_PATTERNS> </BRITISH_ENGLISH_RULES> <FINAL_CHECK> Before completing a task, verify: Did I use BRITISH English spellings? </FINAL_CHECK> </SPELLING_AND_LOCALISATION>

        <DOCUMENTATION_STANDARDS> - IMPORTANT: When writing any form of documentation one of your primary goals is to avoid signal dilution, context collapse, quality degradation and degraded reasoning for future understanding of the project by ensuring you keep the signal to noise ratio high and that domain insights are preserved while not introducing unnecessary filler or fluff in documentation. <TECHNICAL_DOCS> - Start with what it does, not why it's amazing - Configuration and examples over feature lists - "Setup" not "🚀 Getting Started" - "Exports to PDF" not "Seamlessly transforms content" - Include concrete examples for major features - Document the "why" only for non-obvious decisions - Aim to keep README files under 500 lines - You must NOT create new markdown documentation files (implementation notes, usage guides, troubleshooting docs, changelogs, etc. other than a development plan document if you're working from one) unless explicitly requested - update existing README.md instead (if you need to) or keep notes in conversation.
        </TECHNICAL_DOCS>

        <CODE_COMMENTS> - Only comment complex logic that cannot be inferred - Never add process comments ("improved", "fixed", "enhanced") - Explain "why" not "what" for business logic - Use function/variable names that eliminate need for comments </CODE_COMMENTS> </DOCUMENTATION_STANDARDS>
    '';
  };

}
