Return-Path: <linux-sctp+bounces-372-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87824A4A2A1
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Feb 2025 20:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2781899187
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Feb 2025 19:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049031AB52D;
	Fri, 28 Feb 2025 19:24:06 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92B1C3C12
	for <linux-sctp@vger.kernel.org>; Fri, 28 Feb 2025 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740770645; cv=none; b=ZLF0J/vKvt4Enngr3KCkdeM0fumHVSvjSuxm5BjgjzMnJTQDAHrurcR9+fs9MQdI1GMwKo12VIGBb1g323wV3Nu6W9BoXyayIlkrVtJcYCk+974zCVuYRst3IoebCgMfJiRYC2OV0vKgBWXkO6wGYGKIF3pAPXDyvLEj3ox5PIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740770645; c=relaxed/simple;
	bh=kuNLBR+uGOTRYEjjNnHbq7XdRaPyEPhAoNPL6SLeh7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VJejS2XCENgqTY8/9bfmsPRUc8emOWWVGH3JF7+asgdX+u/L9oRlszwQntsJ98BrhK+8dtcg+yOGu/hxBZkjhhkzrz/2skH7LOuK9wjtNLt9OIOQjL6hu70UOZzWDfukiz6HSu0ghY+1C8iokjfVi8QOtc2SnrpHVx15CgQ/j8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
	(envelope-from <laforge@gnumonks.org>)
	id 1to5xi-00EHXL-NO; Fri, 28 Feb 2025 20:23:54 +0100
Received: from laforge by localhost.localdomain with local (Exim 4.98)
	(envelope-from <laforge@gnumonks.org>)
	id 1to5xc-00000002hUX-40Dg;
	Fri, 28 Feb 2025 20:23:48 +0100
Date: Fri, 28 Feb 2025 20:23:48 +0100
From: Harald Welte <laforge@gnumonks.org>
To: linux-sctp@vger.kernel.org
Cc: Vadim Yanitskiy <vyanitskiy@sysmocom.de>
Subject: obtaining metrics of skb duration in sk_receive_queue
Message-ID: <Z8INRNOmfHejh2aw@nataraja>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I'm currently facing a problem whose analysis would require to understand the
latency of how long a DATA chunk stays in the socket receive queue.  Basically
I'm trying to figure out the time between

1) the kernel SCTP stack making data available to the process (socket becomes readable)
2) the process actually performing a sctp_recvmsg to retrieve the data.

Ideally I'd like to see a histogram of those latencies to understand if there's anything
happening in the application process that causes delayed reads.

If anyone has encountered the same situation and/or is familiar with a solution, I'd appreciate
any pointers.

I suppose I could do kprobe+kretprobe on sctp_poll() in order to determine when the socket
becomes readable (return value & EPOLLIN)? Then store the timestamp in a
per-socket map containing a per-skb map containing the timestamps?

But then kprobe/kretprobe for sctp_recvmsg won't be sufficient as I
cannot access the skb at either the function entry nor the function
exit... only somewhere inside the function.  So it looks like a dead
end?

Thanks in advance.

-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

