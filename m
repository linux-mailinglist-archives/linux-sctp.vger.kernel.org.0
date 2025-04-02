Return-Path: <linux-sctp+bounces-467-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD6A790AE
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Apr 2025 16:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66911188CF11
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Apr 2025 14:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8818E20F07D;
	Wed,  2 Apr 2025 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Sa9OHrYk"
X-Original-To: linux-sctp@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869C17C68;
	Wed,  2 Apr 2025 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602647; cv=none; b=IbdZvP/1lHgGTg6jL3m1MeV9NSyPalcVP6YL0bPDBJDN/ZWwCg+uOwucB7C9c16XUqiHlX2ecBXrGst6PlLYxPtBJmLPcmSHZJOaSe1IP+Orc8JqJNTw/3zp2ASv78VPcOu+ZYjmwYStgTOwSQJ40ag05woZrWUXCD/q/JlPiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602647; c=relaxed/simple;
	bh=OBfHirOrTC2pb23RcdLE7kWtv/yuu2ZTh+nJlFlHYJ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N4AU1aoHUKFo9HdMTcEJRnskoYUty/wCKnTf2aGmxrHraBi/0+miwTlGrW5FYColsIIlvoARrPpfPptTnxhHYKbYqEwWKDRmm2H3JhCLTCFi1XhwrXDjjwLlQdb3jmuqHBzu65ovyHZaTCbahkAeMXn5TkUO57MU5q8h/EivyQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Sa9OHrYk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OBfHirOrTC2pb23RcdLE7kWtv/yuu2ZTh+nJlFlHYJ4=; b=Sa9OHrYkEcQWOVuJ6gyqPbjnPr
	/e26dbfCfIs4THr0d0MwKMkHTdS5QHXgbHr4IuYFj2+cB7mCTJds+4KKTwPq2N31Nals+cmC33O16
	SODh8GD1JIL3HmOPDjpm0e+XvTlpAQLRQiiu/I707og5l4ebjr8jxyMh2RdHXdeK9yHqNs3R9MdIp
	ZBsdSN+iGz9HPqfzMI2t4BGfAKeyLTpDqIOjo+cS/ca8JIf5HAO5YXDHXMW5HeI605jj4Uj71vSqE
	mvWZXCUlBOZSLRRvRLBApNQChBUmodB7FlVAhlQox8oiUspi4ehtxnDLWtplajZcNPNEFesHRMPNG
	Uhks7wvQ==;
Received: from 79.red-83-60-111.dynamicip.rima-tde.net ([83.60.111.79] helo=[192.168.1.72])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tzyh8-00AP3c-Oj; Wed, 02 Apr 2025 16:03:54 +0200
Message-ID: <3afa71f8ed15ea4c10b31a4cf41c39ea6edc56cb.camel@igalia.com>
Subject: Re: [PATCH] sctp: check transport existence before processing a
 send primitive
From: Ricardo =?ISO-8859-1?Q?Ca=F1uelo?= Navarro <rcn@igalia.com>
To: Simon Horman <horms@kernel.org>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long	
 <lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, kernel-dev@igalia.com,
 linux-sctp@vger.kernel.org, 	netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 02 Apr 2025 16:03:53 +0200
In-Reply-To: <62dbd9ed967e43e7310cd5333867cfd8930321c4.camel@igalia.com>
References: 
	<20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com>
		 <20250402132141.GO214849@horms.kernel.org>
	 <62dbd9ed967e43e7310cd5333867cfd8930321c4.camel@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

By the way, I'm thinking of setting err to -EAGAIN here so that
userspace can retry the send and sctp_sendmsg() will try again to find
a suitable association or create a new one if necessary, but if someone
more knowledgeable about the SCTP implementation has a better
suggestion about what kind of error to return in this scenario, I'd
appreciate it.

Regards,
Ricardo

