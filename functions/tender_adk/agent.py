import asyncio
import pathlib
from typing import Optional
from google.adk.agents import LlmAgent, SequentialAgent
from google.adk.agents.callback_context import CallbackContext
from google.genai import types
from google.adk.sessions import InMemorySessionService
from google.adk.runners import Runner

from tender_adk.util import load_instruction_from_file

model = "gemini-2.5-flash-preview-05-20"

overview_extraction_agent = LlmAgent(
    name="tender_overview_agent",
    model=model,
    instruction=load_instruction_from_file("overview_instructions.txt"),
    description="Your job is to extract the details from the markdown located in state['extracted_file_content']",
    output_key="overview_data",
)

financial_extraction_agent = LlmAgent(
    name="financial_extraction_agent",
    model=model,
    instruction=load_instruction_from_file("financial_instructions.txt"),
    description="Your job is to extract the financial details from the markdown located in state['extracted_file_content']",
    output_key="financial_data",
)

timeline_extraction_agent = LlmAgent(
    name="timeline_extraction_agent",
    model=model,
    instruction=load_instruction_from_file("timeline_insutructions.txt"),
    description="Your job is to extract the timeline details from the markdown located in state['extracted_file_content']",
    output_key="timeline_data",
)

eligibility_criteria_extraction_agent = LlmAgent(
    name="eligibility_criteria_extraction_agent",
    model=model,
    instruction=load_instruction_from_file("eligibility_criteria_instructions.txt"),
    description="Your job is to extract the eligibilty criteria  from the markdown located in state['extracted_file_content']",
    output_key="eligibility_data",
)

submission_procedure_extraction_agent = LlmAgent(
    name="submission_procedure_extraction_agent",
    model=model,
    instruction=load_instruction_from_file("submission_procedure_instructions.txt"),
    description="Your job is to extract the submission procedure from the markdown located in state['extracted_file_content']",
    output_key="submission_procedure_data",
)


merger_agent = LlmAgent(
    name="SynthesisAgent",
    model=model,
    instruction=load_instruction_from_file("merge_information_insutructions.txt"),
)


tender_extraction_pipeline_agent = SequentialAgent(
    name="TenderExtractionPipelineAgent",
    sub_agents=[
        overview_extraction_agent,
        financial_extraction_agent,
        timeline_extraction_agent,
        eligibility_criteria_extraction_agent,
        submission_procedure_extraction_agent,
        merger_agent,
    ],
    description="Executes a sequence of ocr , overview, finanicial extraction",
)

root_agent = tender_extraction_pipeline_agent


# def modify_output_after_agent(
#     callback_context: CallbackContext,
# ) -> Optional[types.Content]:
#     agent_name = callback_context.agent_name
#     invocation_id = callback_context.invocation_id
#     current_state = callback_context.state.to_dict()
#     print(current_state)
# ocr_agent = LlmAgent(
#     name="ocr_agent",
#     model=model,
#     instruction=load_instruction_from_file("ocr_instructions.txt"),
#     description="Document ingestion and ocr agent",
#     output_key="extracted_file_content",
# )

# parallel_extraction_agent = ParallelAgent(
#     name="ParallelExtractionAgent",
#     sub_agents=[
#         overview_extraction_agent,
#         financial_extraction_agent,
#         timeline_extraction_agent,
#         eligibility_criteria_extraction_agent,
#         submission_procedure_extraction_agent,
#     ],
#     description="Runs multiple extraction agents in parallel to gather information.",
# )
