Return-Path: <linux-sctp+bounces-529-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64503ABAC6F
	for <lists+linux-sctp@lfdr.de>; Sat, 17 May 2025 22:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550DA1B600BD
	for <lists+linux-sctp@lfdr.de>; Sat, 17 May 2025 20:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640501F8744;
	Sat, 17 May 2025 20:32:43 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFF257D;
	Sat, 17 May 2025 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747513963; cv=none; b=ZnCfv5WuW7rBVqg7tysOlMrASLnB71JIySCGN4ygydQUWZYpg7H3N0ZdC3hoQV2ENb54MVZnocSPwFCq+fDQ66gpDVmDErU8qVhGbXNV8LUFnFDOtdRi8t3Yd88FihKUl2Yr8Eo/WMQKdwwThZVIqd+dtjXXYDISUmdck95veqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747513963; c=relaxed/simple;
	bh=qIIxQ9sVCU43yU/3zZ4J8T6U0kzGxVTjqQXqVz/70p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddy+ceuHyWjgwNnl+xWtQJOcz9kpUGT2OKtQ1bhdJQn/Ia/ITgUGkGJkZusN7YznXR/LEgCvCbKAOxXTZVrahSwa4Aw0AqR6wKokUsSg0UPnn7Cwj3OOa5hnFOi6d9QEYNj4SQOSpq7olby6G97WknWUtM0iu+oxuge2AiHZ0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a35b7e60cbso1834044f8f.1;
        Sat, 17 May 2025 13:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747513959; x=1748118759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gkpn3xaIBbZi1bxxpLiN+y0w6dCFyLFgmm6rxbmcas=;
        b=dw13LKxKwBRv7l374NgdW0tBwU7hd9a1LFeQFivwFsRlMTMvZyJeZ6clSqyTFu20dQ
         UYEygKNvC00+sOenaNVCPh5Wu5OLKuRE5p/niKSF2B3lVIsjCv9vuqllSQFPU39J99+y
         J0yNL7eWbrjQ2u+/zb2SVZYWilKwqn892KDpVfJA77PznzzzNdVrLd14Md/l5Q8TJh6+
         X8xuTajmCYdHDf2H3L+9g3Iac0abL8/pehjh3vFlk6dLEJDlulh6r4CNUmanAZrow2QG
         Qjk1G3cEubAy5Kj/S4RMHMoKRXeNtM5aJPwFzNo3w4zeH+fJTKYT+HAeKY+Ercj4VhV5
         rcjA==
X-Forwarded-Encrypted: i=1; AJvYcCVIMf4d3YwcTpHo6ibU63lzVtVSV9FMp4sqhoQZLLtQx5nHfi5/Sdi/HYUQXZcoSlXRa8pl93ZsqNJJtw==@vger.kernel.org, AJvYcCVKjkiETB+Z1qEeuNUhxn2ogOBbwBgA4H5OnE8+sZsd2lqkjaXjwQTq4YuTsJqRz01XvBOvBOJVRC2eXYo=@vger.kernel.org, AJvYcCXpGlObklkNCnlRDgjc/ID6mABV/Bc8nZniqCtsZmG2I2iz+Gl2qWOibj0kpB9PIOGm/4E0xMEh6Szj8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSeRrCiWpdluMsEMt3o8z/dTe7vjE4JuVWHtxV8ecoEOSxyC4y
	PJmRqHt3Ae9GIiKhm7cPoqCtcB3k0IAnEw7ke4sEQErFJUSmRTMDo43kAgBuqQ==
X-Gm-Gg: ASbGncu0FfFxGUDVusEoZYmxHUdSfpEvYFoagWK/Eo6Dg7vL3RK89Mh335M1En3qHns
	3ZDP4mpct3Rf5jzaGxXaDHSUufxZRqdQypKxG5XWE3/mU71JdLkCv9WqR1ve8MvjSZPnX6gR8ST
	Qt4py/OuZ+RsK4KMJwV85zmTzKo43qRVRjIOw6ouH+uoVLQyiCobxA9xCqhsvuyD1WTcaOIQ8a9
	yb7SCapSdMqknxhGt6qF/EWXPYR3YmfUUwh6KkGyW6snuM/33LcpD9FCNW1RcXMwPj3XKzl3co6
	IRE1HDCSxmlYTfUm9i61bt3F6DXbWYK75kksPclefugyciV3ltKLjNAWBv4JDUDRrtNcoUMzit4
	snQ7/oufY
X-Google-Smtp-Source: AGHT+IF4nmgt7DDatNcx/D0XJAtOOMwNnYCOY/5VUcm/4MWcQgU0UcD5GNCZqqVa1d3GOfAzhn0v3w==
X-Received: by 2002:a05:6000:4010:b0:3a3:6b07:bdcc with SMTP id ffacd0b85a97d-3a36b07beebmr351310f8f.15.1747513958838;
        Sat, 17 May 2025 13:32:38 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd515bb5sm79959715e9.23.2025.05.17.13.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 13:32:38 -0700 (PDT)
Message-ID: <ca77a49b-e531-4ebe-abfd-c2f962910943@grimberg.me>
Date: Sat, 17 May 2025 23:32:37 +0300
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
To: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
 <aCbAsCkTPMNE6Ogb@infradead.org> <20250516053100.GA10488@sol>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250516053100.GA10488@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>   	if (queue->hdr_digest && !req->offset)
> -		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
> +		*(__le32 *)(pdu + 1) = nvme_tcp_hdgst(pdu, sizeof(*pdu));

I'd move this assignment to a helper nvme_tcp_set_hdgst(), especially as it
has two call-sites.

Other than that,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me


