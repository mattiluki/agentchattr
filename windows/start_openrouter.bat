@echo off
REM agentchattr — starts server (if not running) + OpenRouter API agent wrapper
cd /d "%~dp0.."
call windows\start_api_agent.bat openrouter
