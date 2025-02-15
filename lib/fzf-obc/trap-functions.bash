#!/usr/bin/env bash

# @description Looping over trigger type by length to detect it
__fzf_obc_trap__get_comp_words_by_ref() {
	local trigger_type
	local option_type="fzf_trigger"
	local trigger_size=-1
	local option
	local option_value
	local new_cur="$cur"
	local final_trigger
	: "${trigger_type_arr:=}"
	for trigger_type in "${trigger_type_arr[@]}";do
		option="${trigger_type}_${option_type}"
		option_value="${!option}"
		if [[ ${cur} =~ (.*)"${option_value}" ]];then
			if [[ "${#option_value}" -gt "${trigger_size}" ]];then
				trigger_size="${#option_value}"
				new_cur="${BASH_REMATCH[1]}"
				final_trigger="${trigger_type}"
			fi
		fi
	done
	if [[ -n "${final_trigger}" ]];then
		__fzf_obc_set_all_current_opt "${final_trigger}"
		# shellcheck disable=SC2034
		[[ "${#LS_COLORS}" == 0 ]] && current_filedir_colors=0
	fi
	cur="${new_cur}"
	# shellcheck disable=SC2034
	current_cur="${cur:-}"
	# shellcheck disable=SC2034
	current_prev="${prev:-}"
	# shellcheck disable=SC2034
	current_words="${words:-}"
	# shellcheck disable=SC2034
	current_cword="${cword:-}"
}
