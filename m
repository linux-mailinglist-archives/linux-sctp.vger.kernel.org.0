Return-Path: <linux-sctp+bounces-528-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B527EABAC6A
	for <lists+linux-sctp@lfdr.de>; Sat, 17 May 2025 22:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA02175A8A
	for <lists+linux-sctp@lfdr.de>; Sat, 17 May 2025 20:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7D207DEE;
	Sat, 17 May 2025 20:30:10 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C971957FF;
	Sat, 17 May 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747513810; cv=none; b=coATRkaZAYM9+VX+cwLomPe/OQPqUpUN7YaD0wH+t713e2+hzNKtQFxYVKTjhLj5r3kG0z18cWCejumCf079HH+e6+T3oEbHiOD1JaecRXFQENp12nN0xvB64xTB5194Z2H1s9R1T7mS/uoh9ZBI4QlM4eF+eXRcAJkENBVk/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747513810; c=relaxed/simple;
	bh=o8dPAkAOuRO1ZrsKaQ+UVHRAKhmxaT6ZPG4kBz5MReQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9mL0/Xbnv46thMvwDOPQQhdKb248iwsHrjkziT5Gop1yA3Kmbzg5p4SeCQCuUGjJMh482BkGPOVLjMmtQhveeTXr7POXmYvAwfIPTa2sAd77vJ8Yg8odZ7dUmQwjEd+32DrcVjU6R3Tqpomcued7KVWJ1kRqgNewtV4YUSDLNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a0ac853894so2630444f8f.3;
        Sat, 17 May 2025 13:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747513807; x=1748118607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ6Cdn9EsHHItXTMwN7zCQevwD72gZm5vOAf0aeJXRQ=;
        b=clEq3ZsQbJG9vYH22wb5ym8F7MfsRrVyEKjWeh5uHfKx93rB56yDhwNI6EzGhTArKs
         pVn2N3te0sKcFEW9mkfS4i63roJlmUSVWBxNhiIR6lsDMkY82SC1a0llWs4S4PNgoFrp
         34RlLkFgMsuBkE6NMU0eIAnQTjbS/HE4RlH3OPz/VdCqZOtFTEuQymF2fkFqVZvSeC9i
         APpwduXPMt3Tn++4taajSPyvk7PG7oqj7VN4Dq1pPmgi2lFgJ8E9cgpKbNb1/NjWVEZu
         BpPXuBhrxDQN5OQEyLmvCGfj/YNXTobn3Y75DO4yVjk1yQzGArHhAWdVm78TPeWIUgcK
         5fVg==
X-Forwarded-Encrypted: i=1; AJvYcCV38w5qhaSlb2eo88Koo9RgM7ZqsENvTFv8x1ckBiJTKUOnFrr39Du18Ly6LyDGES5H8Q2co3Yt8IXTIjU=@vger.kernel.org, AJvYcCVpA4XQFpuHWf3+3qHTjuJWy+F0XVx94Je+6XSOvdtalmi3NxUkT0LUcdBJRu46QdSd7TXOp/JI0JxvSQ==@vger.kernel.org, AJvYcCWWNvHNpEVc/4s79BWszTEmIJPWzqKYE2nLCGX9vW/RKDeSYlVzW5tetNdMVKzeNrfou8hlJ2RLvEhvug==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAo6YJjXqjXYQd+9/jcl4cc3sOisPbDFEraAt5MCl84D2BnPpk
	rvbZLfpHRVVjhO+Uu5gBkKeXp7GY1rpXPrV+xhrwHSr/bA27TUl9WjH+
X-Gm-Gg: ASbGncswEVxnlpvecK819MWv5ohJAoGGYpkq8yIIBGC9mIff+7PImtT2bI+Y11sLSct
	V05jCwjjD886K/Ana0Og9ho1ftcKApVFXa/IMpe+phL+2dIjt9GNklXzE8OkIcyJ+t/6r5KHh4V
	EaAlcqfw0y6vrvBfa1EuL0sfjdukKDO8HUXs782cS1B6hNX9NvjsXEWBop4mH00f8DVT0zQP7Ii
	6dBIxKtAAcVJOzuQCciSsRXmC1hUHlR1lsCjX2TyoTWJh3mwcCg/BpVVznxFLXhyBn8Xc9dFUSu
	hF6FwysUE75laA2fakQilwSMboz9/s5rJPsIxej2hg6VuEPd/HZfRhu0d5a2JFO5nHY78obkwgo
	FdoQMYt1t
X-Google-Smtp-Source: AGHT+IFJqmkPD/xMbGwBXZGrXyFwki275AFmJligoT0yK4fE+E9Upt7H8FQdLTM+3nYtdYFvxxk6Bw==
X-Received: by 2002:a05:6000:40ce:b0:3a3:68c7:e486 with SMTP id ffacd0b85a97d-3a368c7e67bmr2248890f8f.51.1747513806737;
        Sat, 17 May 2025 13:30:06 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8cb2dsm7162321f8f.84.2025.05.17.13.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 13:30:06 -0700 (PDT)
Message-ID: <b208773f-aefc-4708-a2df-17c9f64be270@grimberg.me>
Date: Sat, 17 May 2025 23:30:04 +0300
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
 <8b4db290-00c0-4627-a03e-d39a22c56fcf@grimberg.me>
 <20250517172954.GA1239@sol>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250517172954.GA1239@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> Let's call it rcv_dgst (recv digest) and snd_dgst (send digest).
>> Other than that, looks good to me.
>>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> rcv_dgst would be awfully close to recv_ddgst which holds the on-wire digest
> that is received.  I think I slightly prefer *_crc, since that helps
> differentiate the in-progress values from the finalized values.

yea, sounds good.

