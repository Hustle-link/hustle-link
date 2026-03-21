<script lang="ts">
	import { motion } from 'motion-sv';
	import { MapPin, Briefcase } from '@lucide/svelte';
	import type { JobPosting } from '$lib/utils/models/firestore.models';
	import { dummyJobs } from '$lib/utils/dummy/dummy-jobs';

	const jobs: JobPosting[] = dummyJobs;

	function formatCompensation(amount: number): string {
		return `BWP ${amount.toLocaleString()}`;
	}
</script>

<section id="job-board" data-nav-theme="light" class="bg-linear-to-b from-white to-gray-50 py-32">
	<div class="mx-auto max-w-7xl px-6">
		<motion.div
			initial={{ opacity: 0, y: 30 }}
			animate={{ opacity: 1, y: 0 }}
			class="mb-16 text-center"
		>
			<h2 class="font-space-grotesk mb-6 text-5xl font-bold text-[#0F172A] md:text-6xl">
				Live Job <span class="text-[#00E676]">Opportunities</span>
			</h2>
			<p class="mx-auto max-w-2xl text-xl text-gray-600">
				Real positions from verified Botswana employers, updated in real-time
			</p>
		</motion.div>

		<div class="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
			{#each jobs as job, i (job.id)}
				<motion.div
					initial={{ opacity: 0, y: 30 }}
					animate={{ opacity: 1, y: 0 }}
					transition={{ delay: i * 0.1 }}
					whileHover={{ y: -8 }}
					class="group relative cursor-pointer rounded-2xl border border-gray-200 bg-white p-6 shadow-[0_4px_20px_rgba(0,0,0,0.05)] transition-all duration-300 hover:border-[#00E676] hover:shadow-[0_20px_60px_rgba(0,230,118,0.2)]"
				>
					<!-- Status Badge -->
					<div class="absolute top-4 right-4">
						<span
							class="rounded-full px-3 py-1 text-sm font-bold {job.status === 'active'
								? 'bg-green-100 text-green-700'
								: job.status === 'draft'
									? 'bg-yellow-100 text-yellow-700'
									: 'bg-gray-100 text-gray-700'}"
						>
							{job.status.charAt(0).toUpperCase() + job.status.slice(1)}
						</span>
					</div>

					<div class="mb-4 flex items-start gap-4">
						<div
							class="flex h-14 w-14 shrink-0 items-center justify-center rounded-xl bg-emerald-50 text-2xl font-bold text-[#00E676]"
						>
							{(job.employerCompany ?? job.employerName ?? '?').charAt(0)}
						</div>
						<div class="flex-1">
							<h3
								class="font-space-grotesk mb-1 text-xl font-bold text-[#0F172A] transition-colors group-hover:text-[#00E676]"
							>
								{job.title}
							</h3>
							<p class="font-medium text-gray-600">{job.employerCompany ?? job.employerName}</p>
						</div>
					</div>

					<div class="mb-4 space-y-2">
						{#if job.location}
							<div class="flex items-center gap-2 text-gray-600">
								<MapPin size={16} class="text-[#00E676]" />
								<span class="text-sm">{job.location}</span>
							</div>
						{/if}
						<div class="flex items-center gap-2 text-gray-600">
							<Briefcase size={16} class="text-[#00E676]" />
							<span class="text-sm">{job.skillsRequired.slice(0, 2).join(', ')}</span>
						</div>
					</div>

					<div class="flex items-center justify-between border-t border-gray-100 pt-4">
						<span class="text-lg font-bold text-[#0F172A]">
							{formatCompensation(job.compensation)}
						</span>
						<button
							class="rounded-lg bg-[#00E676] px-4 py-2 font-medium text-white transition-colors hover:bg-emerald-500"
						>
							Apply
						</button>
					</div>

					<!-- Live Indicator -->
					<div class="absolute bottom-4 left-4 flex items-center gap-2">
						<motion.div
							class="h-2 w-2 rounded-full bg-[#00E676]"
							animate={{ scale: [1, 1.3, 1], opacity: [1, 0.7, 1] }}
							transition={{ duration: 2, repeat: Infinity }}
						></motion.div>
						<span class="text-xs text-gray-500">
							{#if job.applicationsCount}
								{job.applicationsCount} applicants
							{:else}
								Live
							{/if}
						</span>
					</div>
				</motion.div>
			{/each}
		</div>

		<motion.div
			initial={{ opacity: 0 }}
			animate={{ opacity: 1 }}
			transition={{ delay: 0.8 }}
			class="mt-12 text-center"
		>
			<button
				class="font-space-grotesk rounded-full border-2 border-[#00E676] px-8 py-4 font-bold text-[#00E676] transition-colors hover:bg-[#00E676] hover:text-white"
			>
				View All 500+ Jobs
			</button>
		</motion.div>
	</div>
</section>
