Return-Path: <linux-sctp+bounces-518-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8785EAB907B
	for <lists+linux-sctp@lfdr.de>; Thu, 15 May 2025 22:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD299E649E
	for <lists+linux-sctp@lfdr.de>; Thu, 15 May 2025 20:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10A1FFC46;
	Thu, 15 May 2025 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="aKcj9GWg"
X-Original-To: linux-sctp@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0184B1E44;
	Thu, 15 May 2025 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339355; cv=none; b=sG53XRXbqzDH85DglOZbJquk3z0Q1l6Q3Yn5vF7vOqPuCg9OIeQTWqP6afJJqiHPdRnaXxqDe2Ge47Wu1yhpqeGlYXOo/kA02LNOuHu2/lbnvKK8VnzGrefZeJR+CyE6hXeFN8crLJbr1q+OfNrEn29IAJfX4kp9Pm2ktq4JP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339355; c=relaxed/simple;
	bh=A0QsmtopcLeIANInXiUpTfS18F2vXDiKcYXRPkJjXvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEq7Pq+IBblKyLGEBrEApwB1Q7fAFSOY1GyzjJRGtv5NQZZUW6/EITfPQwhoPO24KXBaBGq9mW0oOsVZNbeXO71U0HCo4zYlXUYB83PlUl1myx1L9eCC39kbooISnGTa1v+9OGmxzEVmkzeCccIGK5egkYRroH8CxVp76/i0UlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aKcj9GWg; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4Zz1Mr2tZQzltNPr;
	Thu, 15 May 2025 20:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747339350; x=1749931351; bh=B9oIwMKcBufveYc9ju8oUFp2
	RqO/sfgU8Fa2ydk0QLw=; b=aKcj9GWg8ob8btrWjZQvv0QBqnsP73vAIZ5E+ASO
	x9Yhy9gzQ4YxC+0vKPq+lZTOkLuXPlyOib1yd9p9BNBufSC+NYqFKCusKrobTsts
	0mGZgCsq2wTZkID84zE8w9PSUp9W0MtrfFpfL6OL64WfSw0vftSvZIgmzie7ybvw
	yei8qNCjd2enGtQQOSzqtsexcdAXo3TMhA235xtBzKO3ob6dwTv0To2w9faaJ0TS
	MSp+I3RN0t+rPF+a0meReYCv8Vkbc0lGWShCeBQ2yfoRwdvHh7/SgH/P7cvNg1rP
	1qsF95gyonUymwo0yzey+3aSprvUj3hWjjbDD0LsDYWPKg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WeYH8QwpxN3W; Thu, 15 May 2025 20:02:30 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4Zz1Mf6pCZzlvt1v;
	Thu, 15 May 2025 20:02:21 +0000 (UTC)
Message-ID: <69341806-3ffd-41f0-95d6-6c8b750a6b45@acm.org>
Date: Thu, 15 May 2025 13:02:20 -0700
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/10] RDMA/siw: use skb_crc32c() instead of
 __skb_checksum()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org,
 Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-5-ebiggers@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250511004110.145171-5-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/10/25 5:41 PM, Eric Biggers wrote:
> Instead of calling __skb_checksum() with a skb_checksum_ops struct that
> does CRC32C, just call the new function skb_crc32c().  This is faster
> and simpler.
Bernard, since you are the owner and author of the siw driver, please 
help with reviewing this patch.

Eric, do you already have a test case for the siw driver? If not,
multiple tests in the blktests framework use this driver intensively,
including the SRP tests that I wrote myself. See also
https://github.com/osandov/blktests.

Bart.

