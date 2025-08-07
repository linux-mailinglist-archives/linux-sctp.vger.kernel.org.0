Return-Path: <linux-sctp+bounces-596-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC31FB1DF0E
	for <lists+linux-sctp@lfdr.de>; Thu,  7 Aug 2025 23:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59FF1636A3
	for <lists+linux-sctp@lfdr.de>; Thu,  7 Aug 2025 21:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4980421D5BD;
	Thu,  7 Aug 2025 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXPCB5S1"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57424B29;
	Thu,  7 Aug 2025 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754603263; cv=none; b=RKlgr6bbd1bS6bwFmDIWqNh5Q5s6fbBGmEePzEVcmcgtIQzYK+ilArMOwCeIkrqQmCyxr9cqCDi6IT8CEhAndBi5XT+4/lS5ouBrttrtEkma1IY2+1w+DbTmzy84xRNYRKpfPYi2PGfTc/CaOCMzIHs18kus2ExCo/IcXySbueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754603263; c=relaxed/simple;
	bh=hliJGp56g+EsXt7zAi0eCNCEQDrkPtoVAfnkrGjq/Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5O29T7R3Mb1KAZ4Uho9pRkd5UoDLq6q8ef2iJ9z8uBcwyLqhU20b4f4ctbrXwVvDmU9kXi/JcsO7zDGBcKLznXOvjg9ViEgrNgbHwWfP+nDJOKyUokUhC77P7KmqLEHNwjaE8uBSok0RIrPwQflLyORt9S1S7YnsHH8VjjbxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXPCB5S1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b34c068faf8so1469427a12.2;
        Thu, 07 Aug 2025 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754603261; x=1755208061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R5BiksDHPVSLKZXW4mpvxGQA5rtWFHpKt/JSOxrAKLM=;
        b=GXPCB5S1uGavfY/q542nFA8rqEdYMhPEV/O05DNSxUMatFTP3KjOX0ml6HWJqaFYGQ
         qyNEwWeOVk1Rqbn6hl0h41j5ludh7VwA40ji+wU5P4/3r2pe3j8DMSwhUMX2gd3r20hV
         WOxnkgNxGhMnvQ/JJ2tL9jGXYhXkj106wFrlUVl4yt8XqSbuuwwvnZnla09Wgg0uJzU7
         R9DOguIbx5ESB6YiPj3a+HrtH06ypojRCI9nSnt8zF+aEtS5jLaCc5QJzPnCDfEDaQ6R
         0A/WuJgjGl/leKpTeuZoMKkMKCqpdsZUmO7Bz2kSTQPamlIayXjepInhXUX809MVkzsj
         yRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754603261; x=1755208061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5BiksDHPVSLKZXW4mpvxGQA5rtWFHpKt/JSOxrAKLM=;
        b=J1ElYAbECgVUwP5WZ7IXifxNgesGm6tYvLE9b+H0njuPgS5ZKQF2+aRUXfEZOPcRKy
         sq7kvEpFFN8dpbL9qM1tlf55EAMuHdb7Eabms4ZoztW/l74k5T7pa3MIpCuG8L0wrFS0
         2eXLFYCniHfUOAU+Gn9CZJX+TsmCn9dH5FsKWQqquxVJnNhnp4CoCgd9WLF16dZDVcSH
         gRCUiEoIoBWdOydCXAcc6VPDnAh84c9Xaim9upFDbXYZ5PwNybUQyiFye87qoMkBK5Oy
         XGugh7pNRD1fSmm+HsQOiAWV6rJiSYQHGIFn0qjyImSlUL7xO4TVZa+lPVzkOy3MIiId
         L9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUIvSBTEsWFCpAbRxkGsmiKnmi5Tu72MJ2tQQIMNLhZuKYXY4DaXGADdHg2KqmCvxMOvJj5QoFYOwdJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwM84WdMoEmpRt8nt16gSM3sk2eQZBBBOc75OevEBMISTqjaAL/
	fS4+JLXKKDglHFgcF5WaYjM70ZjeQt+0ILAfP4qzp+e+PBGb9a8XN/4O
X-Gm-Gg: ASbGncs9R7Fs/KUIhSCo15VaWSQxIcpj0uBJls8v7BXpbHqzQVqf7FTUlDFrUsnLsBx
	S3aZ5wlYxQc44UTo910soVvWBzYUGcwxZ60+7aOzOWM1ufjocb1k2EUzQm3BTIE8/rF49c1bSAs
	OUnTJv5v+el2DUPX7K2glGvWuXPyDBQl4khaUIFOwhyKwdz0u2ovBPsaJTdb5OdQUf5NVS2X6q4
	YDwsldbbtKeiw/cBnAaQYsyguYzR7qXpEd8LHMgCgRd4OYQaLWLu+ez0w8KcY6/QHee/rIAjPdC
	8gAJuahqrmmxNDZPMcEHIRtQJgnAmvrgmIbj6fvfcXKi80FaqfezJbiPCXr/wVpTIe+SDk74nSG
	Y/4YWPSXVuYbnd7ncRm+ljtjx/2Hvyy5gixXx3hGd3BDADQ==
X-Google-Smtp-Source: AGHT+IHXXWACYIKD7c9rR9mHheqiGtGC+EVeOl6sz8YYPHdaVFVb8PfTwyIPACMKE0hay46jeLFEYw==
X-Received: by 2002:a17:903:1acf:b0:23d:d348:4567 with SMTP id d9443c01a7336-242c200e932mr6664255ad.19.1754603260952;
        Thu, 07 Aug 2025 14:47:40 -0700 (PDT)
Received: from t14s.localdomain ([167.249.65.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aa9257sm194961755ad.153.2025.08.07.14.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 14:47:40 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 28EA610926F6; Thu, 07 Aug 2025 18:47:37 -0300 (-03)
Date: Thu, 7 Aug 2025 18:47:37 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Subject: Re: [PATCH net] sctp: linearize cloned gso packets in sctp_rcv
Message-ID: <aJUe-a8aMnIzNnsr@t14s.localdomain>
References: <dd7dc337b99876d4132d0961f776913719f7d225.1754595611.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd7dc337b99876d4132d0961f776913719f7d225.1754595611.git.lucien.xin@gmail.com>

On Thu, Aug 07, 2025 at 03:40:11PM -0400, Xin Long wrote:
...
> This patch fixes it by linearizing cloned gso packets in sctp_rcv().
> 
> Fixes: 90017accff61 ("sctp: Add GSO support")
> Reported-by: syzbot+773e51afe420baaf0e2b@syzkaller.appspotmail.com
> Reported-by: syzbot+70a42f45e76bede082be@syzkaller.appspotmail.com
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

