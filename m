Return-Path: <linux-sctp+bounces-333-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFD1A309C1
	for <lists+linux-sctp@lfdr.de>; Tue, 11 Feb 2025 12:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00620188C407
	for <lists+linux-sctp@lfdr.de>; Tue, 11 Feb 2025 11:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5171F4262;
	Tue, 11 Feb 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dhWrskw/"
X-Original-To: linux-sctp@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73DA1CEACB;
	Tue, 11 Feb 2025 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272693; cv=none; b=Xxq/GVJlC+W11qXWUY6p0Bmqf/6ymj5HlplmBGTON/SYUyPuKSZC9ETHRNNghf2c8SbC5VTRchNOXxk8Jq8Xv3dLMgO8zE5kPdM9nqlo3t84024e93CdbgsW2Wozd+y9tDVE31CngWsC0+YKkzNFGmJID5ug3WMPS6zvk1G/rD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272693; c=relaxed/simple;
	bh=nZc64ROQtMBsvksqiiVY9LcdEwaoBQcQl2UaguE/5w0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=I76j06yMycwQcDbhmgEmMsZLKc111gYe+r2K08ET5ybYR7fA8Q/FGormIvkqBoWqJSbID35UFXomblTtSqHjYfh71Lbk6qYb/vEng/5nPVyVi+4L3hLvKqTvKa5rmEKGrq7nNO9PhcoSlnUzh7rAjdWqfRkq+RaXJBpskgLMIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dhWrskw/; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739272688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SX5VwgGFraKOYu4YaOaik6I5FHiTMUvQxaqLPeEoq90=;
	b=dhWrskw/Bo6aXVwaDNtm4Y3Mo9B0wkB6HVswPOesLbySk7guj6ZlagMyvSH0KTHW7uaQkw
	gb+Le2XwuHBxZmN1g6wNkUAI2NW+BWKadEIsDZAwQ4Q17WfgdUmKm/Qmdx2tVqIdCKHSDa
	3YX+5rZKGnPkb7xEmJiL368xF+vLWys=
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH net-next] sctp: Remove commented out code
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <b85e552d-5525-4179-a9c4-6553b711d949@intel.com>
Date: Tue, 11 Feb 2025 12:17:54 +0100
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6F08E5F2-761F-4593-9FEB-173ECF18CC71@linux.dev>
References: <20250211102057.587182-1-thorsten.blum@linux.dev>
 <b85e552d-5525-4179-a9c4-6553b711d949@intel.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
X-Migadu-Flow: FLOW_OUT

On 11. Feb 2025, at 11:49, Mateusz Polchlopek wrote:
> On 2/11/2025 11:20 AM, Thorsten Blum wrote:
>> Remove commented out code.
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>>  include/linux/sctp.h | 1 -
>>  1 file changed, 1 deletion(-)
>> diff --git a/include/linux/sctp.h b/include/linux/sctp.h
>> index 836a7e200f39..812011d8b67e 100644
>> --- a/include/linux/sctp.h
>> +++ b/include/linux/sctp.h
>> @@ -222,7 +222,6 @@ struct sctp_datahdr {
>>   __be16 stream;
>>   __be16 ssn;
>>   __u32 ppid;
>> - /* __u8  payload[]; */
>>  };
>>    struct sctp_data_chunk {
> 
> Hi Thorsten
> 
> I don't think we want to remove that piece of code, please refer
> to the discussion under the link:
> 
> https://lore.kernel.org/netdev/cover.1681917361.git.lucien.xin@gmail.com/

Hm, the commit message (dbda0fba7a14) says payload was deleted because
"the member is not even used anywhere," but it was just commented out.
In the cover letter it then explains that "deleted" actually means
"commented out."

However, I can't follow the reasoning in the cover letter either:

"Note that instead of completely deleting it, we just leave it as a
comment in the struct, signalling to the reader that we do expect
such variable parameters over there, as Marcelo suggested."

Where do I find Marcelo's suggestion and the "variable parameters over
there?"

Thanks,
Thorsten

