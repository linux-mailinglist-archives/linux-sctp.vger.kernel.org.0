Return-Path: <linux-sctp+bounces-1117-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFR6E+XesmncQQAAu9opvQ
	(envelope-from <linux-sctp+bounces-1117-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 16:42:29 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E20BF274BF5
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 16:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00A3C30B4FBB
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 15:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266F13876B5;
	Thu, 12 Mar 2026 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="e3vaIiIY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50444387581
	for <linux-sctp@vger.kernel.org>; Thu, 12 Mar 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329962; cv=pass; b=SyQ95btMPYk7AvPabL+TlTvo4zPJg6oHuayaj/5wr408kg4IUViw9TdPPkMpC6P1rZyyNskdVMgJROpblvj2UQN6axnDsr53ibSdLGDFjvvaH3+OJgqtsuoDnTo/KOHfo/FV424x05z9BRYWgqLMgxJm7p0F/v2ZRDi3gIJdWPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329962; c=relaxed/simple;
	bh=4tNFTOMSBZ1/Qp5RW7o3J5ezE7GBWsXKNJ/prrgOmk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3hPzuQ73ylGR0LsfwvysSXm3T3/1OZutUrw+eTl58iEac+TkCc+REPXXCb14ut6LcDJnKqUSrBghvcEttoufcrctjnxfmqarAgIpBunOpzxLW4NSbHhGjdL0Zx8BnQ0SW3JcLsLjsjuPoRYm2WApzPgt/sjgzG5zAC/SsQaxpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=e3vaIiIY; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64937edbc9eso1229193d50.2
        for <linux-sctp@vger.kernel.org>; Thu, 12 Mar 2026 08:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773329958; cv=none;
        d=google.com; s=arc-20240605;
        b=EH55bavxvHJMLh4aRtyydpL0z04Oi/rcB47kMjyS2jM3MW/8LyrRaEN8VMcLixcBtS
         4DFVTEt2zLwhLjSdzojDDme75d2CUSuKLl5CP/dXFsVlH1fGLfrbNoo52FYtjp6La4nT
         HFPM/a8AvFMJI178meZzdfQj6ehUsGdRBO5z1s/4q5I9tUYYFx2SAIcGsAhF1YmFKtt3
         UmjgetjuwoSSq84UEfGWdep3yBZG8XK8eKuPoDJeRM/wRff5cOWKZ6ijSVc5eDq2GBM8
         kGQx8ocUXmawtqKfu5I4edMWdQNT1bGkDcrZZnpLIYc+cgpcsOfInr1uKlxETJ19UVNa
         8NZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
        fh=+GCPaThyzPMC7v8Gg6/Ped3Pu4vOYyQD2YujZAxfz6o=;
        b=YYP0kkRle3NQXW5tQzO6gzQ5GJb3jO5xErYEwGugMGiscoiUCjTUdMK0FRwbslDvCm
         E7KThE4ayqBhSGcoBG4HhFOLPMDIZesZ5jAuaCQXzHffhekLS5f203loIvcGJ/3Buzj2
         37wpWjR5D8Az0q15EA+hZkL9Fh9SJqoLgS0MJHc6pYTCcWYdc5y2cRUiP0f+iMD5Xq4v
         O4e6dxSJiDR8iwFXMWNTFIkwJj3S8W8/WRWgyTc7CqnPNNrAV8ELjVvsbw06WV9jwIIR
         kpgeYIOnM0nJnMTzAg+sBUe9/M8RdhWlJ18QQqSyBRNsYtsfab7szfTtWja9LFQ14kl8
         gONw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773329958; x=1773934758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
        b=e3vaIiIYGWUOtCfN3v0i0XwlQU8iKw5tKJiDxrs5BpZgUFpI7tsKG3ZooWaPnqOdPC
         Z8SAY5DTLTvpjaOB6s9bQ3ZxX+LcGGgsdf6NZnIPHM+cPfYf7mdvQUxOUB0MAZatRAPX
         OPlQ6GS038tCrg8KJ4MGW9OOzjznHa++hyHmoFietr8QqWOe5FW8fUSSVZIetM87CB5M
         jIZEMQ7uYMS4Ig4PCqqRV43UmxiY9EVL0EW92WOQZ4YI2E2FPpEUlNbyASWYFFksXS3t
         9mACIIHPFuYoU4rBir3aqJDHbJg+APFP1wB7a8eG0Ml1cARiYuzc0pJgDxzADpeGYDNg
         MfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329958; x=1773934758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
        b=YfCSBUV4EBQGhMCT45L9WWazjMF+3F31tQvG75qX+8KAF0ojp97MlIr2BjNo3LPvHr
         cp1TiSHFcQPGBO7TIRL+TvGX3vvDghzrwEqmrjheNR/PMJrh+j94BJyFvMVtVDF3tsZV
         lBP+n/9GehJVibK1NvKuLkQ7lO6s4fut37PtnGNRWy+ED/XYkG9I4e4GNJcQ8hEExpNZ
         Oe03R4b4tnPwNmcqMn0ZlRpsOJZyVUBOW6rUhgQaT7MM8+BlDId/FkZcRD1TRnci9SvA
         h5Pz+qyVUHdBnPjuWlWf73HAzZsub3KXDyqJg5LEtlAYx0YnbHm0AYj/a4S7lpp5Egjl
         p5zA==
X-Forwarded-Encrypted: i=1; AJvYcCUHklu9qMoT+SY8jAlCkzr0RISAHQ3Yl40/p3q+kXOoi2FxabPiQUakvF4dMC3kToJqwJdByHGhkxdu@vger.kernel.org
X-Gm-Message-State: AOJu0YwdIVvsP2XW/elT4XHsV4/+39nx6TIfO9MHXpZFLVsOxcR6XY4q
	O3dBAKgbwaM6SYguQh97QixVmfheYXhh09loxK1qm3hQK4gtS3scFB1hH6z59dOicvEIkH1hLdb
	nTQnMhgsmxh3bfkvYENk1B3yR1xhA8elY39e+CMFVBA==
X-Gm-Gg: ATEYQzzjfdu0VWv1PYns4/2flsximbjpM5i+Brm0Hq35n4xSEKd67QjCG31nbfa8EBt
	07uHdotOH6k9n9cm8GwMiHNyEcTA+xL3HbTjgN3LX77kjwNjHsJD7W0z934JZJPPHJburIOUBPp
	Z6e2tV5+IZjQIGIKVpKfhNAkmXN+8RmDYwfRNcVwJSKXXfkkmQf7wGniTe4v3v6EAToifYvdSMx
	4bC2+mvMRipENkgt59NLkURF4mYCvaAY75NUCfXq1uzQvfsIO0BBO2K/5vEQX9A0OlUc/1le4so
	oM9a9RgGpmlcEWKfyA==
X-Received: by 2002:a53:bb8d:0:b0:64d:5742:5ab0 with SMTP id
 956f58d0204a3-64d6577eb37mr4463263d50.43.1773329958142; Thu, 12 Mar 2026
 08:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-2-vineeth@bitbyteword.org> <20260312111255.7925b4e2@gandalf.local.home>
In-Reply-To: <20260312111255.7925b4e2@gandalf.local.home>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Thu, 12 Mar 2026 11:39:06 -0400
X-Gm-Features: AaiRm53MQsKCFNMcydaZ5MLANW9ImopAkQThe-DUzJ0WQT8Ah4MCG48E4vTQfog
Message-ID: <CAO7JXPhg-Etspj9YahZrq8cmZ2K6AGWDrMnHO+oD96P_SmOLBw@mail.gmail.com>
Subject: Re: [PATCH 01/15] tracepoint: Add trace_invoke_##name() API
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	dev@openvswitch.org, Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
	dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
	Eddie James <eajames@linux.ibm.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[bitbyteword.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1117-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bitbyteword.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,ilvokhin.com,kernel.org,efficios.com,redhat.com,kernel.dk,vger.kernel.org,davemloft.net,google.com,iogearbox.net,gmail.com,ovn.org,lists.sourceforge.net,openvswitch.org,intel.com,lists.freedesktop.org,linaro.org,amd.com,linux.intel.com,samsung.com,lists.linaro.org,linux.ibm.com,codeconstruct.com.au,jms.id.au,lists.ozlabs.org,ffwll.ch,sang-engineering.com,analog.com,hansenpartnership.com,oracle.com,fb.com,suse.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[72];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vineeth@bitbyteword.org,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[bitbyteword.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bitbyteword.org:dkim,bitbyteword.org:email,infradead.org:email,goodmis.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E20BF274BF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:13=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 12 Mar 2026 11:04:56 -0400
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
>
> > Add trace_invoke_##name() as a companion to trace_##name().  When a
> > caller already guards a tracepoint with an explicit enabled check:
> >
> >   if (trace_foo_enabled() && cond)
> >       trace_foo(args);
> >
> > trace_foo() internally repeats the static_branch_unlikely() test, which
> > the compiler cannot fold since static branches are patched binary
> > instructions.  This results in two static-branch evaluations for every
> > guarded call site.
> >
> > trace_invoke_##name() calls __do_trace_##name() directly, skipping the
> > redundant static-branch re-check.  This avoids leaking the internal
> > __do_trace_##name() symbol into call sites while still eliminating the
> > double evaluation:
> >
> >   if (trace_foo_enabled() && cond)
> >       trace_invoke_foo(args);   /* calls __do_trace_foo() directly */
> >
> > Three locations are updated:
> > - __DECLARE_TRACE: invoke form omits static_branch_unlikely, retains
> >   the LOCKDEP RCU-watching assertion.
> > - __DECLARE_TRACE_SYSCALL: same, plus retains might_fault().
> > - !TRACEPOINTS_ENABLED stub: empty no-op so callers compile cleanly
> >   when tracepoints are compiled out.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > Assisted-by: Claude:claude-sonnet-4-6
>
> I'm guessing Claude helped with the other patches. Did it really help wit=
h this one?
>

Claude wrote and build tested the whole series based on my guidance
and prompt :-). I verified the series before sending it out, but
claude did the initial work.

Thanks,
Vineeth

