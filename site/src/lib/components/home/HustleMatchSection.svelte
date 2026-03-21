<script lang="ts">
	import { motion } from 'motion-sv';
	import { CircleCheckIcon, Zap, Upload, MapPin } from '@lucide/svelte';
	// import htmlattribute from svelte-attributes package

	let features = [
		{
			title: 'Skill-Sync',
			description: 'AI-powered matching that analyzes your BQA certifications',
			icon: CircleCheckIcon,
			color: 'from-emerald-400 to-teal-400',
			metric: '98% Match'
		},
		{
			title: 'Instant Pula',
			description: 'Get paid directly through verified payment channels',
			icon: Zap,
			color: 'from-yellow-400 to-orange-400',
			metric: 'Payment Verified'
		},
		{
			title: 'Cert-Upload',
			description: 'Drag and drop your certificates for instant verification',
			icon: Upload,
			color: 'from-blue-400 to-indigo-400',
			metric: 'BQA Verified'
		},
		{
			title: 'Local Reach',
			description: 'Connect with employers across Gaborone, Francistown & beyond',
			icon: MapPin,
			color: 'from-pink-400 to-rose-400',
			metric: 'Live Pings'
		}
	];
</script>

<section id="hustle-match" data-nav-theme="light" class="bg-white py-32">
	<div class="mx-auto max-w-7xl px-6">
		<motion.div
			initial={{ opacity: 0, y: 30 }}
			animate={{ opacity: 1, y: 0 }}
			class="mb-16 text-center"
		>
			<h2 class="font-space-grotesk mb-6 text-5xl font-bold text-[#0F172A] md:text-6xl">
				The <span class="text-[#00E676]">Hustle-Match</span> System
			</h2>
			<p class="mx-auto max-w-2xl text-xl text-gray-600">
				Four powerful features that transform your skills into opportunities
			</p>
		</motion.div>

		<div class="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
			{#each features as feature, i (i)}
				<motion.div
					initial={{ opacity: 0, y: 30 }}
					animate={{ opacity: 1, y: 0 }}
					transition={{ delay: i * 0.1 }}
					whileHover={{
						y: -10,
						rotateY: 5,
						rotateX: 5
					}}
					class="group relative rounded-3xl border border-gray-200 bg-white p-8 transition-all duration-300 hover:border-[#00E676]"
					style={{
						transformStyle: 'preserve-3d',
						boxShadow: '0 10px 40px rgba(0, 230, 118, 0.1)'
					}}
				>
					<!-- Glassmorphism Overlay -->
					<div
						class="absolute inset-0 rounded-3xl border border-white/20 bg-linear-to-br from-white/80 to-white/40 opacity-0 backdrop-blur-xl transition-opacity group-hover:opacity-100"
					></div>

					<div class="relative z-10">
						<div
							class={`h-16 w-16 rounded-2xl bg-linear-to-br ${feature.color} mb-6 flex items-center justify-center`}
						>
							<feature.icon class="text-white" size={32} />
						</div>

						<h3 class="font-space-grotesk mb-3 text-2xl font-bold text-[#0F172A]">
							{feature.title}
						</h3>

						<p class="mb-6 text-gray-600">{feature.description}</p>

						<div class="flex items-center gap-2">
							<div class="h-2 flex-1 overflow-hidden rounded-full bg-gray-200">
								<motion.div
									class={`h-full bg-linear-to-r ${feature.color}`}
									initial={{ width: 0 }}
									animate={{ width: '98%' }}
									transition={{ delay: i * 0.2 + 0.5, duration: 1 }}
								></motion.div>
							</div>
							<span class="text-sm font-bold text-[#00E676]">
								{feature.metric}
							</span>
						</div>
					</div>
				</motion.div>
			{/each}
		</div>
	</div>
</section>
